# glTF types



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

type GLTFAnimationChannelTarget
    id::AbstractString
    path::AbstractString
    extensions::Nullable{Dict}
    extras
end
GLTFAnimationChannelTarget(id::AbstractString, path::AbstractString; extensions=Nullable{Dict}(), extras...) = GLTFAnimationChannelTarget(id, path, extensions, extras)

type GLTFAnimationChannel
    sampler::GLTFAnimationSampler
    target::GLTFAnimationChannelTarget
    extensions::Nullable{Dict}
    extras
end
GLTFAnimationChannel(sampler::GLTFAnimationSampler, target::GLTFAnimationChannelTarget; extensions=Nullable{Dict}(), extras...) = GLTFAnimationChannel(sampler, target, extensions, extras)

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


# asset
type GLTFProfile
    api::AbstractString
    version::VersionNumber
    extensions::Nullable{Dict}
    extras
end
GLTFProfile(;api="WebGL", version="1.0.3", extensions=Nullable{Dict}(), extras...) = GLTFProfile(api, version, extensions, extras)

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

type GLTFBufferView
    buffer::GLTFBuffer
    byteOffset::Integer
    byteLength::Integer
    target::Nullable{Integer}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFBufferView(buffer::GLTFBuffer, byteOffset::Integer; byteLength=0, target=Nullable{Integer}(),
               name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFBufferView(buffer, byteOffset, byteLength, target, name, extensions, extras)

type GLTFAccessor
    bufferView::GLTFBufferView
    byteOffset::Integer
    componentType::Integer
    count::Integer
    _type::AbstractString
    byteStride::Integer
    max::Nullable{Array{Number, 1}}
    min::Nullable{Array{Number, 1}}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFAccessor(bufferView::GLTFBufferView, byteOffset::Integer, componentType::Integer, count::Integer, _type::AbstractString;
             byteStride=0, max=Nullable{Array{Number, 1}}(), min=Nullable{Array{Number, 1}}(), name=Nullable{AbstractString}(), extensions=Nullable{Dict}(),
             extras...) = GLTFAccessor(bufferView, byteOffset, componentType, count, _type, byteStride, max, min, name, extensions, extras)


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


# shader & program & technique & material
type GLTFShader
    uri::AbstractString
    _type::Integer
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFShader(uri::AbstractString, _type::Integer; name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFShader(uri, _type, name, extensions, extras)

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

type GLTFTechniqueStates
    enable::Array{Integer, 1}
    functions::Nullable{GLTFTechniqueStatesFunctions}
    extensions::Nullable{Dict}
    extras
end
GLTFTechniqueStates(;enable=Integer[], functions=Nullable{GLTFTechniqueStatesFunctions}(), extensions=Nullable{Dict}(), extras...) = GLTFTechniqueStates(enable, functions, extensions, extras)

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

type GLTFMesh
    primitives::Array{GLTFMeshPrimitive, 1}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFMesh(;primitives=GLTFMeshPrimitive[], name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFMesh(primitives, name, extensions, extras)


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

type GLTFScene
    nodes::Dict{AbstractString, GLTFNode}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFScene(;nodes=Dict{AbstractString, GLTFNode}(), name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFScene(nodes, name, extensions, extras)


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

type GLTFImage
    uri::AbstractString
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFImage(uri::AbstractString; name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), extras...) = GLTFImage(uri, name, extensions, extras)

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
