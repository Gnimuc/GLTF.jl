# glTF types

type GLTFProfile
    api::AbstractString
    version::AbstractString
    extensions::Nullable{Dict}
    extras
end
GLTFProfile() = GLTFProfile("WebGL", "1.0.3")
GLTFProfile(api::AbstractString, version::AbstractString; extensions=Nullable{Dict}(), args...) = GLTFProfile(api, version, extensions, args)


type GLTFAnimation
    #
    channels
    parameters
    samplers
    name
    extensions
    extras
end

type GLTFAsset
    version::AbstractString
    premultipliedAlpha::Bool
    profile::GLTFProfile
    copyright::Nullable{AbstractString}
    generator::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFAsset(version::AbstractString, premultipliedAlpha=false, profile=GLTFProfile(); copyright=Nullable{AbstractString}(), generator=Nullable{AbstractString}(), extensions=Nullable{Dict}(), args...) = GLTFAsset(version, premultipliedAlpha, profile, copyright, generator, extensions, args)

type GLTFBuffer
    uri::AbstractString
    byteLength::Integer
    _type::AbstractString
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFBuffer(uri::AbstractString, byteLength=0, _type="arraybuffer"; name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), args...) = GLTFBuffer(uri, byteLength, _type, name, extensions, args)

type GLTFBufferView
    buffer::GLTFBuffer
    byteOffset::Integer
    byteLength::Integer
    target::Nullable{Integer}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFBufferView(buffer::GLTFBuffer, byteOffset::Integer, byteLength=0; target=Nullable{Integer}(), name=Nullable{String}(), extensions=Nullable{Dict}(), args...) = GLTFBufferView(buffer, byteOffset, byteLength, target, name, extensions, args)

type GLTFAccessor
    bufferView::GLTFBufferView
    byteOffset::Integer
    componentType::Integer
    count::Integer
    _type::AbstractString
    byteStride::Integer
    max::Nullable{Int}
    min::Nullable{Int}
    name::Nullable{AbstractString}
    extensions::Nullable{Dict}
    extras
end
GLTFAccessor(bufferView::GLTFBufferView, byteOffset::Integer, componentType::Integer, count::Integer, _type::AbstractString, byteStride=0; max=Nullable{Int}(), min=Nullable{Int}(), name=Nullable{AbstractString}(), extensions=Nullable{Dict}(), args...) = GLTFAccessor(bufferView, byteOffset, componentType, count, _type, byteStride, max, min, name, extensions, args)

type GLTFCamera
    _type::AbstractString
    #
    orthographic
    perspective
    name
    extensions
    extras
end

type GLTFImage
    uri::AbstractString
    #
    name
    extensions
    extras
end

type GLTFMaterial
    values  # {}
    #
    technique
    name
    extensions
    extras
end

type GLTFMesh
    primitives
    #
    name
    extensions
    extras
end

type GLTFNode
    children::AbstractString
    matrix  #
    rotation #
    scale #
    translation #
    #
    camera
    skeletons
    skin
    jointName
    meshes
    name
    extensions
    extras
end

type GLTFProgram
    fragmentShader::AbstractString
    vertexShader::AbstractString
    attributes #
    #
    name
    extensions
    extras
end

type GLTFSampler
    magFilter::Integer # 9729
    minFilter::Integer # 9986
    wrapS::Integer # 10497
    wrapT::Integer # 10497
    #
    name
    extensions
    extras
end

type GLTFScene
    nodes #
    #
    name
    extensions
    extras
end

type GLTFShader
    uri::AbstractString
    _type::Integer
    #
    name
    extensions
    extras
end

type GLTFSkin
    inverseBindMatrices::AbstractString
    jointNames
    bindShapeMatrix #
    #
    name
    extensions
    extras
end

type GLTFTechnique
    program::AbstractString
    parameters #
    attributes #
    uniforms #
    states #
    #
    name
    extensions
    extras
end

type GLTFStates
    enable #
    #
    functions
    extensions
    extras
end

type GLTFFunctions
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
    extensions
    extras
end

type GLTFTexture
    sampler::AbstractString
    source::AbstractString
    format::Integer # 6408
    internalFormat::Integer # 6408
    target::Integer # 3553
    _type::Integer # 5121
    #
    name
    extensions
    extras
end

type GLTFObject
    accessors::Array{GLTFAccessor, 1}
    animation::Array{GLTFAnimation, 1}
    asset::GLTFAsset
    buffers::Array{GLTFBuffer, 1}
    bufferViews::Array{GLTFBufferView, 1}
    cameras::Array{GLTFCamera, 1}
    images::Array{GLTFImage, 1}
    materials::Array{GLTFMaterial, 1}
    meshes::Array{GLTFMesh, 1}
    nodes::Array{GLTFNode, 1}
    programs::Array{GLTFProgram, 1}
    samplers::Array{GLTFSampler, 1}
    scenes::Array{GLTFScene, 1}
    shaders::Array{GLTFShader, 1}
    skins::Array{GLTFSkin, 1}
    techniques::Array{GLTFTechnique, 1}
    textures::Array{GLTFTexture, 1}
    extensionsUsed::Array{AbstractString, 1}
    extensions
    #
    scene::AbstractString
end

export GLTFProfile
export GLTFAsset
export GLTFBuffer
export GLTFBufferView
export GLTFAccessor
