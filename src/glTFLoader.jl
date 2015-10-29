# glTF loader
import JSON
include("glTFTypes.jl")


# rootDict = JSON.parsefile("./src/sphere.gltf")
rootDict = JSON.parsefile("./src/vc.gltf")


# asset
function loadprofile(profileDict::Dict{AbstractString, Any})
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
            profile = loadprofile(assetDict["profile"])
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
# @show loadasset(rootDict)

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
# @show loadprograms(rootDict)

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
# @show loadtechniqueparameter("ambient", "technique1", rootDict)









# techniques = rootDict["techniques"]
# @show keys(techniques)
# for key in keys(techniques)
#     techniqueDict = techniques[key]
#     @show techniqueDict
#     program =
#
# end



# @show rootDict["programs"]
