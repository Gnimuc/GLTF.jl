# glTF loader


# animation
function loadanimationsampler(samplerID::AbstractString, animationID::AbstractString, rootDict::Dict{AbstractString, Any})
    samplerDict = rootDict["animations"][animationID]["samplers"][samplerID]
    @assert haskey(samplerDict, "input") "not a valid animation sampler obj: cannot access property input."
    input = get(samplerDict, "input", nothing)
    @assert haskey(samplerDict, "output") "not a valid animation sampler obj: cannot access property output."
    output = get(samplerDict, "output", nothing)
    interpolation = get(samplerDict, "interpolation", "LINEAR")
    extensions = get(samplerDict, "extensions", Nullable{Dict}())
    extras = get(samplerDict, "extras", ())
    sampler = GLTFAnimationSampler(input, output, interpolation, extensions, extras)
end

function loadanimationsamplers(animationID::AbstractString, rootDict::Dict{AbstractString, Any})
    samplersDict = rootDict["animations"][animationID]["samplers"]
    samplers = Dict{AbstractString, GLTFAnimationSampler}()
    for key in keys(samplersDict)
        sampler = loadanimationsampler(key, animationID, rootDict)
        merge!(samplers, Dict([(key, sampler)]))
    end
    return samplers
end

function loadanimationchannels(animationID::AbstractString, rootDict::Dict{AbstractString, Any})
    channelsDict = rootDict["animations"][animationID]["channels"]
    channels = Array{GLTFAnimationChannel, 1}()
    for channelDict in channelsDict
        @assert haskey(channelDict, "sampler") "not a valid animation channel dict: cannot access property sampler."
        samplerID = get(channelDict, "sampler", nothing)
        sampler = loadanimationsampler(samplerID, animationID, rootDict)
        @assert haskey(channelDict, "target") "not a valid animation channel dict: cannot access property target."
        targetDict = get(channelDict, "target", nothing)
        @assert haskey(targetDict, "id") "not a valid animation channel target dict: cannot access property id."
        id = get(targetDict, "id", nothing)
        @assert haskey(targetDict, "path") "not a valid animation channel target dict: cannot access property path."
        path = get(targetDict, "path", nothing)
        targetExtensions = get(targetDict, "extensions", Nullable{Dict}())
        targetExtras = get(targetDict, "extras", ())
        target = GLTFAnimationChannelTarget(id, path, targetExtensions, targetExtras)
        extensions = get(channelDict, "extensions", Nullable{Dict}())
        extras = get(channelDict, "extras", ())
        channel = GLTFAnimationChannel(sampler, target, extensions, extras)
        push!(channels, channel)
    end
    return channels
end

function loadanimation(animationID::AbstractString, rootDict::Dict{AbstractString, Any})
    animationDict = rootDict["animations"][animationID]
    channels = loadanimationchannels(animationID, rootDict)
    parameters = animationDict["parameters"]    # ?
    samplers = loadanimationsamplers(animationID, rootDict)
    name = get(animationDict, "name", Nullable{AbstractString}())
    extensions = get(animationDict, "extensions", Nullable{Dict}())
    extras = get(animationDict, "extras", ())
    animation = GLTFAnimation(channels, parameters, samplers, name, extensions, extras)
end

function loadanimations(rootDict::Dict{AbstractString, Any})
    animationsDict = rootDict["animations"]
    animations = Dict{AbstractString, GLTFAnimation}()
    for key in keys(animationsDict)
        animation = loadanimation(key, rootDict)
        merge!(animations, Dict([(key, animation)]))
    end
    return animations
end


# asset
function loadprofile(rootDict::Dict{AbstractString, Any})
    profileDict = rootDict["asset"]["profile"]
    api = get(profileDict, "api", "WebGL")
    version = get(profileDict, "version", v"1.0.3")
    extensions = get(profileDict, "extensions", Nullable{Dict}())
    extras = get(profileDict, "extras", ())
    profile = GLTFProfile(api, version, extensions, extras)
end

function loadasset(rootDict::Dict{AbstractString, Any})
    asset = nothing
    if haskey(rootDict, "asset")
        assetDict = rootDict["asset"]
        version = get(assetDict, "version", 0)
        premultipliedAlpha = get(assetDict, "premultipliedAlpha", false)
        if haskey(assetDict, "profile")
            profile = loadprofile(rootDict)
        else
            profile = GLTFProfile()
        end
        copyright = get(assetDict, "copyright", Nullable{AbstractString}())
        generator = get(assetDict, "generator", Nullable{AbstractString}())
        extensions = get(assetDict, "extensions", Nullable{Dict}())
        extras = get(assetDict, "extras", ())
        asset = GLTFAsset(version, premultipliedAlpha, profile, copyright, generator, extensions, extras)
    end
    return asset
end


# buffer & bufferView & accessor
function loadbuffer(bufferID::AbstractString, rootDict::Dict{AbstractString, Any})
    bufferDict = rootDict["buffers"][bufferID]
    @assert haskey(bufferDict, "uri") "not a valid buffer obj: cannot access property uri."
    uri = get(bufferDict, "uri", nothing)
    byteLength = get(bufferDict, "byteLength", 0)
    _type = get(bufferDict, "type", "arraybuffer")
    name = get(bufferDict, "name", Nullable{AbstractString}())
    extensions = get(bufferDict, "extensions", Nullable{Dict}())
    extras = get(bufferDict, "extras", ())
    buffer = GLTFBuffer(uri, byteLength, _type, name, extensions, extras)
end

function loadbuffers(rootDict::Dict{AbstractString, Any})
    buffersDict = rootDict["buffers"]
    buffers = Dict{AbstractString, GLTFBuffer}()
    for key in keys(buffersDict)
        buffer = loadbuffer(key, rootDict)
        merge!(buffers, Dict([(key, buffer)]))
    end
    return buffers
end

function loadbufferview(viewID::AbstractString, rootDict::Dict{AbstractString, Any})
    viewDict = rootDict["bufferViews"][viewID]
    @assert haskey(viewDict, "buffer") "not a valid bufferView obj: cannot access property buffer."
    bufferID = get(viewDict, "buffer", nothing)
    buffer = loadbuffer(bufferID, rootDict)
    @assert haskey(viewDict, "byteOffset") "not a valid bufferView obj: cannot access property byteOffset."
    byteOffset = get(viewDict, "byteOffset", nothing)
    byteLength = get(viewDict, "byteLength", 0)
    target = get(viewDict, "target", Nullable{Integer}())
    name = get(viewDict, "name", Nullable{AbstractString}())
    extensions = get(viewDict, "extensions", Nullable{Dict}())
    extras = get(viewDict, "extras", ())
    view = GLTFBufferView(buffer, byteOffset, byteLength, target, name, extensions, extras)
end

function loadbufferviews(rootDict::Dict{AbstractString, Any})
    viewsDict = rootDict["bufferViews"]
    views = Dict{AbstractString, GLTFBufferView}()
    for key in keys(viewsDict)
        view = loadbufferview(key, rootDict)
        merge!(views, Dict([(key, view)]))
    end
    return views
end

function loadaccessor(accessorID::AbstractString, rootDict::Dict{AbstractString, Any})
    accessorDict = rootDict["accessors"][accessorID]
    @assert haskey(accessorDict, "bufferView") "not a valid accessor obj: cannot access property bufferView."
    bufferViewID = get(accessorDict, "bufferView", nothing)
    view = loadbufferview(bufferViewID, rootDict)
    @assert haskey(accessorDict, "byteOffset") "not a valid accessor obj: cannot access property byteOffset."
    byteOffset = get(accessorDict, "byteOffset", nothing)
    @assert haskey(accessorDict, "componentType") "not a valid accessor obj: cannot access property componentType."
    componentType = get(accessorDict, "componentType", nothing)
    @assert haskey(accessorDict, "byteOffset") "not a valid accessor obj: cannot access property count."
    count = get(accessorDict, "count", nothing)
    @assert haskey(accessorDict, "byteOffset") "not a valid accessor obj: cannot access property type."
    _type = get(accessorDict, "type", nothing)
    byteStride = get(accessorDict, "byteStride", 0)
    max = get(accessorDict, "max", Array{Int, 1}())
    min = get(accessorDict, "min", Array{Int, 1}())
    name = get(accessorDict, "name", Nullable{AbstractString}())
    extensions = get(accessorDict, "extensions", Nullable{Dict}())
    extras = get(accessorDict, "extras", ())
    accessor = GLTFAccessor(view, byteOffset, componentType, count, _type, byteStride, Nullable(max), Nullable(min), name, extensions, extras)
end

function loadaccessors(rootDict::Dict{AbstractString, Any})
    accessorsDict = rootDict["accessors"]
    accessors = Dict{AbstractString, GLTFAccessor}()
    for key in keys(accessorsDict)
        accessor = loadaccessor(key, rootDict)
        merge!(accessors, Dict([(key, accessor)]))
    end
    return accessors
end


# camera
function loadcameraorthograhic(cameraID::AbstractString, rootDict::Dict{AbstractString, Any})
    orthographicDict = rootDict["cameras"][cameraID]["orthographic"]
    @assert haskey(orthographicDict, "xmag") "not a valid orthographic obj: cannot access property xmag."
    xmag = get(orthographicDict, "xmag", nothing)
    @assert haskey(orthographicDict, "ymag") "not a valid orthographic obj: cannot access property ymag."
    ymag = get(orthographicDict, "ymag", nothing)
    @assert haskey(orthographicDict, "zfar") "not a valid orthographic obj: cannot access property zfar."
    zfar = get(orthographicDict, "zfar", nothing)
    @assert haskey(orthographicDict, "znear") "not a valid orthographic obj: cannot access property znear."
    znear = get(orthographicDict, "znear", nothing)
    extensions = get(orthographicDict, "extensions", Nullable{Dict}())
    extras = get(orthographicDict, "extras", ())
    orthographic = GLTFCameraOrthographic(xmag, ymag, zfar, znear, extensions, extras)
end

function loadcameraperspective(cameraID::AbstractString, rootDict::Dict{AbstractString, Any})
    perspectiveDict = rootDict["cameras"][cameraID]["perspective"]
    @assert haskey(perspectiveDict, "yfov") "not a valid perspective obj: cannot access property yfov."
    yfov = get(perspectiveDict, "yfov", nothing)
    @assert haskey(perspectiveDict, "zfar") "not a valid perspective obj: cannot access property zfar."
    zfar = get(perspectiveDict, "zfar", nothing)
    @assert haskey(perspectiveDict, "znear") "not a valid perspective obj: cannot access property znear."
    znear = get(perspectiveDict, "znear", nothing)
    aspectRatio = get(perspectiveDict, "aspectRatio", Nullable{Number}())
    extensions = get(perspectiveDict, "extensions", Nullable{Dict}())
    extras = get(perspectiveDict, "extras", ())
    perspective = GLTFCameraPerspective(yfov, zfar, znear, aspectRatio, extensions, extras)
end

function loadcamera(cameraID::AbstractString, rootDict::Dict{AbstractString, Any})
    cameraDict = rootDict["cameras"][cameraID]
    @assert haskey(cameraDict, "type") "not a valid camera obj: cannot access property type."
    _type = get(cameraDict, "type", nothing)
    if _type == "orthographic"
        orthographic = loadcameraorthograhic(cameraID, rootDict)
    else
        orthographic = Nullable{GLTFCameraOrthographic}()
    end
    if _type == "perspective"
        perspective = loadcameraperspective(cameraID, rootDict)
    else
        perspective = Nullable{GLTFCameraPerspective}()
    end
    name = get(cameraDict, "name", Nullable{AbstractString}())
    extensions = get(cameraDict, "extensions", Nullable{Dict}())
    extras = get(cameraDict, "extras", ())
    camera = GLTFCamera(_type, orthographic, perspective, name, extensions, extras)
end


# shader & program & technique & material
function loadshader(shaderID::AbstractString, rootDict::Dict{AbstractString, Any})
    shaderDict = rootDict["shaders"][shaderID]
    @assert haskey(shaderDict, "uri") "not a valid shader obj: cannot access property uri."
    uri = get(shaderDict, "uri", nothing)
    @assert haskey(shaderDict, "type") "not a valid shader obj: cannot access property type."
    _type = get(shaderDict, "type", nothing)
    name = get(shaderDict, "name", Nullable{AbstractString}())
    extensions = get(shaderDict, "extensions", Nullable{Dict}())
    extras = get(shaderDict, "extras", ())
    shader = GLTFShader(uri, _type, name, extensions, extras)
end

function loadshaders(rootDict::Dict{AbstractString, Any})
    shadersDict = rootDict["shaders"]
    shaders = Dict{AbstractString, GLTFShader}()
    for key in keys(shadersDict)
        shader = loadshader(key, rootDict)
        merge!(shaders, Dict([(key, shader)]))
    end
    return shaders
end

function loadprogram(programID::AbstractString, rootDict::Dict{AbstractString, Any})
    programDict = rootDict["programs"][programID]
    shadersDict = rootDict["shaders"]
    @assert haskey(programDict, "fragmentShader") "not a valid program obj: cannot access property fragmentShader."
    fragmentShaderID = get(programDict, "fragmentShader", nothing)
    fragmentShader = loadshader(fragmentShaderID, rootDict)
    @assert haskey(programDict, "vertexShader") "not a valid program obj: cannot access property vertexShader."
    vertexShaderID = get(programDict, "vertexShader", nothing)
    vertexShader = loadshader(vertexShaderID, rootDict)
    attributes = get(programDict, "attributes", AbstractString[])
    name = get(programDict, "name", Nullable{AbstractString}())
    extensions = get(programDict, "extensions", Nullable{Dict}())
    extras = get(programDict, "extras", ())
    program = GLTFProgram(fragmentShader, vertexShader, attributes, name, extensions, extras)
end

function loadprograms(rootDict::Dict{AbstractString, Any})
    programsDict = rootDict["programs"]
    programs = Dict{AbstractString, GLTFProgram}()
    for key in keys(programsDict)
        program = loadprogram(key, rootDict)
        merge!(programs, Dict([(key, program)]))
    end
    return programs
end

function loadtechniqueparameter(parameterID::AbstractString, techniqueID::AbstractString , rootDict::Dict{AbstractString, Any})
    parameterDict = rootDict["techniques"][techniqueID]["parameters"][parameterID]
    _type = get(parameterDict, "type", nothing)
    count = get(parameterDict, "count", Nullable{Integer}())
    node = get(parameterDict, "node", Nullable{AbstractString}())
    semantic = get(parameterDict, "semantic", Nullable{AbstractString}())
    value = get(parameterDict, "value", Nullable{Bool}())
    extensions = get(parameterDict, "extensions", Nullable{Dict}())
    extras = get(parameterDict, "extras", ())
    parameter = GLTFTechniqueParameter(_type, count, node, semantic, value, extensions, extras)
end

function loadtechniqueparameters(techniqueID::AbstractString , rootDict::Dict{AbstractString, Any})
    parametersDict = rootDict["techniques"][techniqueID]["parameters"]
    parameters = Dict{AbstractString, GLTFTechniqueParameter}()
    for key in keys(parametersDict)
        parameter = loadtechniqueparameter(key, techniqueID, rootDict)
        merge!(parameters, Dict([(key, parameter)]))
    end
    return parameters
end

function loadtechniquestatesfuncs(techniqueID::AbstractString, rootDict::Dict{AbstractString, Any})
    funcsDict = rootDict["techniques"][techniqueID]["states"]["functions"]
    blendColor = get(funcsDict, "blendColor", [0, 0, 0, 0])
    blendEquationSeparate = get(funcsDict, "blendEquationSeparate", [32774, 32774])
    blendFuncSeparate = get(functions, "blendFuncSeparate", [1, 1, 0, 0])
    colorMask = get(funcsDict, "colorMask", [true, true, true, true])
    cullFace = get(funcsDict, "cullFace", [1029])
    depthFunc = get(funcsDict, "depthFunc", [513])
    depthMask = get(funcsDict, "depthMask", [true])
    depthRange = get(funcsDict, "depthRange", [0, 1])
    frontFace = get(funcsDict, "frontFace", [2305])
    lineWidth = get(funcsDict, "lineWidth", [1])
    polygonOffset = get(funcsDict, "polygonOffset", [0, 0])
    scissor = get(funcsDict, "scissor", [0, 0, 0, 0])
    extensions = get(funcsDict, "extensions", Nullable{Dict}())
    extras = get(funcsDict, "extras", ())
    funcs = GLTFTechniqueStatesFunctions(blendColor, blendEquationSeparate, blendFuncSeparate, colorMask, cullFace, depthFunc,
                                         depthMask, depthRange, frontFace, lineWidth, polygonOffset, scissor, extensions, extras)
end

function loadtechniquestates(techniqueID::AbstractString, rootDict::Dict{AbstractString, Any})
    statesDict = rootDict["techniques"][techniqueID]["states"]
    enable = get(statesDict, "enable", Integer[])
    functions = get(statesDict, "functions", Nullable{GLTFTechniqueStatesFunctions}())
    extensions = get(statesDict, "extensions", Nullable{Dict}())
    extras = get(statesDict, "extras", ())
    states = GLTFTechniqueStates(enable, functions, extensions, extras)
end

function loadtechnique(techniqueID::AbstractString, rootDict::Dict{AbstractString, Any})
    techniqueDict = rootDict["techniques"][techniqueID]
    @assert haskey(techniqueDict, "program") "not a valid technique obj: cannot access property program."
    programID = get(techniqueDict, "program", nothing)
    program = loadprogram(programID, rootDict)
    parameters = loadtechniqueparameters(techniqueID, rootDict)
    attributes = get(techniqueDict, "attributes", Dict{AbstractString, AbstractString}())
    uniforms = get(techniqueDict, "uniforms", Dict{AbstractString, AbstractString}())
    states = loadtechniquestates(techniqueID, rootDict)
    name = get(techniqueDict, "name", Nullable{AbstractString}())
    extensions = get(techniqueDict, "extensions", Nullable{Dict}())
    extras = get(techniqueDict, "extras", ())
    GLTFTechnique(program, parameters, attributes, uniforms, states, name, extensions, extras)
end

function loadtechniques(rootDict::Dict{AbstractString, Any})
    techniquesDict = rootDict["techniques"]
    techniques = Dict{AbstractString, GLTFTechnique}()
    for key in keys(techniquesDict)
        technique = loadtechnique(key, rootDict)
        merge!(techniques, Dict([(key, technique)]))
    end
    return techniques
end

function loadmaterial(materialID::AbstractString, rootDict::Dict{AbstractString, Any})
    materialDict = rootDict["materials"][materialID]
    values = get(materialDict, "values", Dict{AbstractString, Any}())
    if haskey(materialDict, "technique")
        techniqueID = get(materialDict, "technique", nothing)
        technique = loadtechnique(techniqueID, rootDict)
    else
        technique = Nullable{GLTFTechnique}()
    end
    name = get(materialDict, "name", Nullable{AbstractString}())
    extensions = get(materialDict, "extensions", Nullable{Dict}())
    extras = get(materialDict, "extras", ())
    material = GLTFMaterial(values, technique, name, extensions, extras)
end

function loadmaterials(rootDict::Dict{AbstractString, Any})
    materialsDict = rootDict["materials"]
    materials = Dict{AbstractString, GLTFMaterial}()
    for key in keys(materialsDict)
        material = loadmaterial(key, rootDict)
        merge!(materials, Dict([(key, material)]))
    end
    return materials
end


# mesh
# function loadprimitive()
# end
