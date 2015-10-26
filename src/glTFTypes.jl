# glTF types
import Base: show


# animation
type GLTFAnimationSampler
    input::AbstractString
    output::AbstractString
    interpolation::AbstractString
    extensions::Nullable{Dict}
    extras
end
GLTFAnimationSampler(input::AbstractString, output::AbstractString; interpolation="LINEAR",
                     extensions=Nullable{Dict}(), extras...) = GLTFAnimationSampler(input, output, interpolation, extensions, extras)
function show(io::IO, x::GLTFAnimationSampler)
    print(io, "GLTFAnimationSampler:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFAnimationChannelTarget
    id::AbstractString
    path::AbstractString
    extensions::Nullable{Dict}
    extras
end
GLTFAnimationChannelTarget(id::AbstractString, path::AbstractString; extensions=Nullable{Dict}(), extras...) = GLTFAnimationChannelTarget(id, path, extensions, extras)
function show(io::IO, x::GLTFAnimationChannelTarget)
    print(io, "GLTFAnimationChannelTarget:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFAnimationChannel
    sampler::GLTFAnimationSampler
    target::GLTFAnimationChannelTarget
    extensions::Nullable{Dict}
    extras
end
GLTFAnimationChannel(sampler::GLTFAnimationSampler, target::GLTFAnimationChannelTarget; extensions=Nullable{Dict}(), extras...) = GLTFAnimationChannel(sampler, target, extensions, extras)
function show(io::IO, x::GLTFAnimationChannel)
    print(io, "GLTFAnimationChannel:")
    print(io, "\n  sampler: GLTFAnimationSampler")
    for name in fieldnames(x.sampler)
        value = eval(:($x.sampler.$name))
        print(io, "\n    ", name, ": ", value)
    end
    print(io, "\n  target: GLTFAnimationChannelTarget")
    for name in fieldnames(x.target)
        value = eval(:($x.target.$name))
        print(io, "\n    ", name, ": ", value)
    end
    print(io, "\n  extensions: $(x.extensions)")
    print(io, "\n  extras: $(x.extras)")
end

type GLTFAnimation
    channels::Array{GLTFAnimationChannel, 1}
    parameters::Dict{AbstractString, AbstractString}
    samplers::Dict{AbstractString, GLTFAnimationSampler}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFAnimation(;channels=GLTFAnimationChannel[], parameters=Dict{AbstractString, AbstractString}(),
              samplers=Dict{AbstractString, GLTFAnimationSampler}(), name=Nullable{AbstractString}(),
              extensions=Nullable{Dict}(), extras...) = GLTFAnimation(channels, parameters, samplers, name, extensions, extras)
function show(io::IO, x::GLTFAnimation)
  print(io, "GLTFAnimation:")
  print(io, "\n  channels", ": ", typeof(x.channels))
  print(io, "\n  parameters", ": ", x.parameters)
  print(io, "\n  samplers", ": ", typeof(x.samplers))
  print(io, "\n  name", ": ", x.name)
  print(io, "\n  extensions", ": ", x.extensions)
  print(io, "\n  extras", ": ", x.extras)
end


# asset
type GLTFProfile
    api::AbstractString
    version::VersionNumber
    extensions::Nullable{Dict}
    extras
end
GLTFProfile(;api="WebGL", version="1.0.3", extensions=Nullable{Dict}(), extras...) = GLTFProfile(api, version, extensions, extras)
function show(io::IO, x::GLTFProfile)
    print(io, "GLTFProfile:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end


type GLTFAsset
    version::VersionNumber
    premultipliedAlpha::Bool
    profile::GLTFProfile
    copyright::Nullable{AbstractString}
    generator::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFAsset(version; premultipliedAlpha=false, profile=GLTFProfile(),
          copyright=Nullable{AbstractString}(), generator=Nullable{AbstractString}(),
          extensions=Nullable{Dict}(), extras...) = GLTFAsset(version, premultipliedAlpha, profile, copyright, generator, extensions, extras)
function show(io::IO, x::GLTFAsset)
  print(io, "GLTFAsset:")
  for name in fieldnames(x)
      if name == :profile
          print(io, "\n  ", name, ": GLTFProfile:")
          for name in fieldnames(x.profile)
              value = eval(:($x.profile.$name))
              print(io, "\n    ", name, ": ", value)
          end
      else
          value = eval(:($x.$name))
          print(io, "\n  ", name, ": ", value)
      end
  end
end


# buffer & bufferView & accessor
type GLTFBuffer
    uri::AbstractString
    byteLength::Integer
    _type::AbstractString
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFBuffer(uri::AbstractString; byteLength=0, _type="arraybuffer", name=Nullable{AbstractString}(),
           extensions=Nullable{Dict}(), extras...) = GLTFBuffer(uri, byteLength, _type, name, extensions, extras)
function show(io::IO, x::GLTFBuffer)
    print(io, "GLTFBuffer:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFBufferView
    buffer::GLTFBuffer
    byteOffset::Integer
    byteLength::Integer
    target::Nullable{GLenum}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFBufferView(buffer::GLTFBuffer, byteOffset::Integer; byteLength=0, target=Nullable{GLenum}(),
               name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFBufferView(buffer, byteOffset, byteLength, target, name, extensions, extras)
function show(io::IO, x::GLTFBufferView)
    print(io, "GLTFBufferView:")
    print(io, "\n  buffer: GLTFBuffer")
    for name in fieldnames(x.buffer)
        value = eval(:($x.buffer.$name))
        print(io, "\n    ", name, ": ", value)
    end
    for name in fieldnames(x)[2:end]
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFAccessor
    bufferView::GLTFBufferView
    byteOffset::Integer
    componentType::GLenum
    count::Integer
    _type::AbstractString
    byteStride::Integer
    max::Nullable{Array{Number, 1}}
    min::Nullable{Array{Number, 1}}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFAccessor(bufferView::GLTFBufferView, byteOffset::Integer, componentType::GLenum, count::Integer, _type::AbstractString;
             byteStride=0, max=Nullable{Array{Number, 1}}(), min=Nullable{Array{Number, 1}}(), name=Nullable{AbstractString}(), extensions=Nullable{Dict}(),
             extras...) = GLTFAccessor(bufferView, byteOffset, componentType, count, _type, byteStride, max, min, name, extensions, extras)
function show(io::IO, x::GLTFAccessor)
    print(io, "GLTFAccessor:")
    print(io, "\n  bufferView: GLTFBufferView...")
    for name in fieldnames(x)[2:end]
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end


# camera
type GLTFCameraOrthographic
    xmag::Number
    ymag::Number
    zfar::Number
    znear::Number
    extensions::Nullable{Dict}
    extras
end
GLTFCameraOrthographic(xmag::Number, ymag::Number, zfar::Number, znear::Number; extensions=Nullable{Dict}(), extras...) = GLTFCameraOrthographic(xmag, ymag, zfar, znear, extensions, extras)
function show(io::IO, x::GLTFCameraOrthographic)
    print(io, "GLTFCameraOrthographic:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFCameraPerspective
    yfov::Number
    zfar::Number
    znear::Number
    aspectRatio::Nullable{Number}
    extensions::Nullable{Dict}
    extras
end
GLTFCameraPerspective(yfov::Number, zfar::Number, znear::Number; aspectRatio=Nullable{Number}(),
                extensions=Nullable{Dict}(), extras...) = GLTFCameraPerspective(yfov, zfar, znear, aspectRatio, extensions, extras)
function show(io::IO, x::GLTFCameraPerspective)
    print(io, "GLTFCameraPerspective:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFCamera
    _type::AbstractString
    orthographic::Nullable{GLTFCameraOrthographic}
    perspective::Nullable{GLTFCameraPerspective}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFCamera(_type::AbstractString; orthographic=Nullable{GLTFCameraOrthographic}(), perspective=Nullable{GLTFCameraPerspective}(),
           name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFCamera(_type, orthographic, perspective, name, extensions, extras)
function show(io::IO, x::GLTFCamera)
    print(io, "GLTFCamera:")
    print(io, "\n  type: ", x._type)
    if !isnull(x.orthographic)
        print(io, "\n  orthographic: Nullable(GLTFCameraOrthographic)")
        for name in fieldnames(x.orthographic.value)
            value = eval(:($x.orthographic.value.$name))
            print(io, "\n    ", name, ": ", value)
        end
    end
    if !isnull(x.perspective)
        print(io, "\n  perspective: Nullable(GLTFCameraPerspective)")
        for name in fieldnames(x.perspective.value)
            value = eval(:($x.perspective.value.$name))
            print(io, "\n    ", name, ": ", value)
        end
    end
    print(io, "\n  name: $(x.name)")
    print(io, "\n  extensions: $(x.extensions)")
    print(io, "\n  extras: $(x.extras)")
end


# shader & program & technique & material
type GLTFShader
    uri::AbstractString
    _type::Integer
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFShader(uri::AbstractString, _type::Integer; name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFShader(uri, _type, name, extensions, extras)
function show(io::IO, x::GLTFShader)
    print(io, "GLTFShader:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        if name == :_type
            name = "type"
        end
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFProgram
    fragmentShader::GLTFShader
    vertexShader::GLTFShader
    attributes::Array{AbstractString, 1}  # names in shader
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFProgram(fragmentShader::GLTFShader, vertexShader::GLTFShader; attributes=AbstractString[],
            name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFProgram(fragmentShader, vertexShader, attributes, name, extensions, extras)
function show(io::IO, x::GLTFProgram)
    print(io, "GLTFProgram:")
    print(io, "\n  fragmentShader: GLTFShader")
    for name in fieldnames(x.fragmentShader)
        value = eval(:($x.fragmentShader.$name))
        if name == :_type
            name = "type"
        end
        print(io, "\n    ", name, ": ", value)
    end
    print(io, "\n  vertexShader: GLTFShader")
    for name in fieldnames(x.vertexShader)
        value = eval(:($x.vertexShader.$name))
        if name == :_type
            name = "type"
        end
        print(io, "\n    ", name, ": ", value)
    end
    print(io, "\n  attributes: $(x.attributes)")
    print(io, "\n  name: $(x.name)")
    print(io, "\n  extensions: $(x.extensions)")
    print(io, "\n  extras: $(x.extras)")
end

# type GLTFTechniqueParameter{T<:Union{Number, Bool, AbstractString, Array{Number, 1}, Array{Bool, 1}, Array{AbstractString, 1}}}
type GLTFTechniqueParameter
    _type::Integer
    count::Nullable{Integer}
    node::Nullable{AbstractString}
    semantic::Nullable{AbstractString}
    # value::Nullable{T}
    value
    extensions::Nullable{Dict}
    extras
end
GLTFTechniqueParameter(_type::Integer; count=Nullable{Integer}(), node=Nullable{AbstractString}(), semantic=Nullable{AbstractString}(), value=Nullable{Bool}(),
                       extensions=Nullable{Dict}(), extras...) = GLTFTechniqueParameter(_type, count, node, semantic, value, extensions, extras)
function show(io::IO, x::GLTFTechniqueParameter)
    print(io, "GLTFTechniqueParameter:")
    print(io, "\n  type: ", x._type)
    for name in fieldnames(x)[2:end]
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFTechniqueStatesFunctions
    blendColor
    blendEquationSeparate
    blendFuncSeparate
    colorMask
    cullFace
    depthFunc
    depthMask
    depthRange
    frontFace
    lineWidth
    polygonOffset
    scissor
    extensions::Nullable{Dict}
    extras
end
GLTFTechniqueStatesFunctions(;blendColor=[0, 0, 0, 0], blendEquationSeparate=[32774, 32774],
              blendFuncSeparate=[1, 1, 0, 0], colorMask=[true, true, true, true],
              cullFace=[1029], depthFunc=[513], depthMask=[true], depthRange=[0, 1],
              frontFace=[2305], lineWidth=[1], polygonOffset=[0, 0], scissor=[0, 0, 0, 0],
              extensions=Nullable{Dict}(), extras...) = GLTFTechniqueStatesFunctions(blendColor, blendEquationSeparate, blendFuncSeparate, colorMask, cullFace, depthFunc,
                                                                                     depthMask, depthRange, frontFace, lineWidth, polygonOffset, scissor, extensions, extras)
function show(io::IO, x::GLTFTechniqueStatesFunctions)
    print(io, "GLTFTechniqueStatesFunctions:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFTechniqueStates
    enable::Array{Integer, 1}
    functions::Nullable{GLTFTechniqueStatesFunctions}
    extensions::Nullable{Dict}
    extras
end
GLTFTechniqueStates(;enable=Integer[], functions=Nullable{GLTFTechniqueStatesFunctions}(), extensions=Nullable{Dict}(), extras...) = GLTFTechniqueStates(enable, functions, extensions, extras)
function show(io::IO, x::GLTFTechniqueStates)
    print(io, "GLTFTechniqueStates:")
    print(io, "\n  enable: $(x.enable)")
    print(io, "\n  functions: Nullable{GLTFTechniqueStatesFunctions}...")
    print(io, "\n  extensions: $(x.extensions)")
    print(io, "\n  extras: $(x.extras)")
end

type GLTFTechnique
    program::GLTFProgram
    parameters::Dict{AbstractString, GLTFTechniqueParameter}  # "modelViewMatrix" is a paramsinstance  "position" is a paramsinstance
    attributes::Dict{AbstractString, AbstractString}  # "a_position"=>position
    uniforms::Dict{AbstractString, AbstractString}  # "u_modelViewMatrix"=>"modelViewMatrix"
    states::GLTFTechniqueStates
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFTechnique(program::GLTFProgram; parameters=Dict{AbstractString, GLTFTechniqueParameter}(), attributes=Dict{AbstractString, AbstractString}(),
              uniforms=Dict{AbstractString, AbstractString}(), states=GLTFTechniqueStates(), name=Nullable{AbstractString}(), extensions=Nullable{Dict}(),
              extras...) = GLTFTechnique(program, parameters, attributes, uniforms, states, name, extensions, extras)
function show(io::IO, x::GLTFTechnique)
    print(io, "GLTFTechnique:")
    for name in fieldnames(x)
        if name == :program
            print(io, "\n  program: GLTFProgram...")
        elseif name == :states
            print(io, "\n  states: GLTFTechniqueStates...")
        else
            value = eval(:($x.$name))
            print(io, "\n  ", name, ": ", value)
        end
    end
end

# type GLTFMaterial{T<:Union{Number, Bool, AbstractString, Array{Number, 1}, Array{Bool, 1}, Array{AbstractString, 1}}}
type GLTFMaterial
    values::Dict{AbstractString, Any}
    technique::Nullable{GLTFTechnique}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFMaterial(;values=Dict{AbstractString, Any}(), technique=Nullable{GLTFTechnique}(),
             name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFMaterial(values, technique, name, extensions, extras)
function show(io::IO, x::GLTFMaterial)
    print(io, "GLTFMaterial:")
    print(io, "\n  values: $(x.values)")
    print(io, "\n  technique: Nullable(GLTFTechnique)...")
    print(io, "\n  name: $(x.name)")
    print(io, "\n  extensions: $(x.extensions)")
    print(io, "\n  extras: $(x.extras)")
end

# mesh
type GLTFMeshPrimitive
    material::GLTFMaterial
    attributes::Dict{AbstractString, AbstractString}
    mode::Integer
    indices::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFMeshPrimitive(material::GLTFMaterial; attributes=Dict{AbstractString, AbstractString}(), mode=4,
              indices=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFMeshPrimitive(material, attributes, mode, indices, extensions, extras)
function show(io::IO, x::GLTFMeshPrimitive)
    print(io, "GLTFMeshPrimitive:")
    print(io, "\n  material: GLTFMaterial...")
    for name in fieldnames(x)[2:end]
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFMesh
    primitives::Array{GLTFMeshPrimitive, 1}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFMesh(;primitives=GLTFMeshPrimitive[], name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFMesh(primitives, name, extensions, extras)
function show(io::IO, x::GLTFMesh)
    print(io, "GLTFMesh:")
    print(io, "\n  primitives", ": ", typeof(x.primitives))
    print(io, "\n  name: $(x.name)")
    print(io, "\n  extensions: $(x.extensions)")
    print(io, "\n  extras: $(x.extras)")
end

# skin & node & scene
type GLTFSkin{T<:AbstractString}
    inverseBindMatrices::AbstractString
    jointNames::Array{T, 1}
    bindShapeMatrix
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFSkin{T<:AbstractString}(inverseBindMatrices::AbstractString, jointNames::Array{T, 1}; bindShapeMatrix=[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1],
         name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFSkin(inverseBindMatrices, jointNames, bindShapeMatrix, name, extensions, extras)
function show(io::IO, x::GLTFSkin)
    print(io, "GLTFSkin:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFNode
    children::Array{AbstractString, 1}
    matrix
    rotation
    scale
    translation
    camera::Nullable{GLTFCamera}
    skeletons::Nullable{Array{AbstractString, 1}}
    skin::Nullable{GLTFSkin}
    jointName::Nullable{AbstractString}
    meshes::Nullable{Dict{AbstractString, GLTFMesh}}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFNode(;children=AbstractString[], matrix=[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1], rotation=[0,0,0,0.1],
         scale=[1,1,1], translation=[0,0,0], camera=Nullable{GLTFCamera}(), skeletons=Nullable{Array{AbstractString, 1}}(),
         skin=Nullable{GLTFSkin}(), jointName=Nullable{AbstractString}(), meshes=Nullable{Dict{AbstractString, GLTFMesh}}(),
         name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFNode(children, matrix, rotation, scale, translation, camera,
                                                                                             skeletons, skin, jointName, meshes, name, extensions, extras)
function show(io::IO, x::GLTFNode)
    print(io, "GLTFNode:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFScene
    nodes::Dict{AbstractString, GLTFNode}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFScene(;nodes=Dict{AbstractString, GLTFNode}(), name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFScene(nodes, name, extensions, extras)
function show(io::IO, x::GLTFScene)
    print(io, "GLTFScene:")
    print(io, "\n  nodes", ": ", typeof(x.nodes))
    print(io, "\n  name: $(x.name)")
    print(io, "\n  extensions: $(x.extensions)")
    print(io, "\n  extras: $(x.extras)")
end


# sampler & image & texture
type GLTFSampler
    magFilter::Integer
    minFilter::Integer
    wrapS::Integer
    wrapT::Integer
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFSampler(;magFilter=9729, minFilter=9729, wrapS=10497, wrapT=10497, name=Nullable{AbstractString}(),
            extensions=Nullable{Dict}(), extras...) = GLTFSampler(magFilter, minFilter, wrapS, wrapT, name, extensions, extras)
function show(io::IO, x::GLTFSampler)
    print(io, "GLTFSampler:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFImage
    uri::AbstractString
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFImage(uri::AbstractString; name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFImage(uri, name, extensions, extras)
function show(io::IO, x::GLTFImage)
    print(io, "GLTFImage:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFTexture
    sampler::GLTFSampler
    source::GLTFImage
    format::Integer
    internalFormat::Integer
    target::Integer
    _type::Integer
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFTexture(sampler::GLTFSampler, source::GLTFImage; format=6408, internalFormat=6408, target=3553, _type=5121,
            name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFTexture(sampler, source, format, internalFormat, target, _type, name, extensions, extras)
function show(io::IO, x::GLTFTexture)
    print(io, "GLTFTexture:")
    print(io, "\n  sampler: GLTFSampler")
    for name in fieldnames(x.sampler)
        value = eval(:($x.sampler.$name))
        print(io, "\n    ", name, ": ", value)
    end
    print(io, "\n  source: GLTFImage")
    for name in fieldnames(x.source)
        value = eval(:($x.source.$name))
        print(io, "\n    ", name, ": ", value)
    end
    for name in fieldnames(x)[3:end]
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", value)
    end
end

type GLTFObject
    accessors::Dict{AbstractString, GLTFAccessor}
    animations::Dict{AbstractString, GLTFAnimation}
    asset::GLTFAsset
    buffers::Dict{AbstractString, GLTFBuffer}
    bufferViews::Dict{AbstractString, GLTFBufferView}
    cameras::Dict{AbstractString, GLTFCamera}
    images::Dict{AbstractString, GLTFImage}
    materials::Dict{AbstractString, GLTFMaterial}
    meshes::Dict{AbstractString, GLTFMesh}
    nodes::Dict{AbstractString, GLTFNode}
    programs::Dict{AbstractString, GLTFProgram}
    samplers::Dict{AbstractString, GLTFSampler}
    scenes::Dict{AbstractString, GLTFScene}
    shaders::Dict{AbstractString, GLTFShader}
    skins::Dict{AbstractString, GLTFSkin}
    techniques::Dict{AbstractString, GLTFTechnique}
    textures::Dict{AbstractString, GLTFTexture}
    extensionsUsed::Array{AbstractString, 1}
    scene::Nullable{GLTFScene}
    extensions::Nullable{Dict}
    extras
end
GLTFObject(;accessors=Dict{AbstractString, GLTFAccessor}(),
            animations=Dict{AbstractString, GLTFAnimation}(),
            asset=GLTFAsset(v"0.0.0"),
            buffers=Dict{AbstractString, GLTFBuffer}(),
            bufferViews=Dict{AbstractString, GLTFBufferView}(),
            cameras=Dict{AbstractString, GLTFCamera}(),
            images=Dict{AbstractString, GLTFImage}(),
            materials=Dict{AbstractString, GLTFMaterial}(),
            meshes=Dict{AbstractString, GLTFMesh}(),
            nodes=Dict{AbstractString, GLTFNode}(),
            programs=Dict{AbstractString, GLTFProgram}(),
            samplers=Dict{AbstractString, GLTFSampler}(),
            scenes=Dict{AbstractString, GLTFScene}(),
            shaders=Dict{AbstractString, GLTFShader}(),
            skins=Dict{AbstractString, GLTFSkin}(),
            techniques=Dict{AbstractString, GLTFTechnique}(),
            textures=Dict{AbstractString, GLTFTexture}(),
            extensionsUsed=Array{AbstractString, 1}(),
            scene=Nullable{GLTFScene}(),
            extensions=Nullable{Dict}(),
            extras...) = GLTFObject(accessors, animations, asset, buffers, bufferViews, cameras, images,
                                    materials, meshes, nodes, programs, samplers, scenes, shaders, skins,
                                    techniques, textures, extensionsUsed, scene, extensions, extras)
function show(io::IO, x::GLTFObject)
    print(io, "GLTFObject:")
    for name in fieldnames(x)
        value = eval(:($x.$name))
        print(io, "\n  ", name, ": ", typeof(value))
    end
end




export GLTFAnimationSampler
export GLTFAnimationChannelTarget
export GLTFAnimationChannel
export GLTFAnimation
export GLTFProfile
export GLTFAsset
export GLTFBuffer
export GLTFBufferView
export GLTFAccessor
export GLTFCameraOrthographic
export GLTFCameraPerspective
export GLTFCamera
export GLTFProgram
export GLTFTechniqueParameter
export GLTFTechniqueStatesFunctions
export GLTFTechniqueStates
export GLTFTechnique
export GLTFMaterial
export GLTFMeshPrimitive
export GLTFMesh
export GLTFSkin
export GLTFNode
export GLTFScene
export GLTFSampler
export GLTFImage
export GLTFTexture
export GLTFShader
export GLTFObject
