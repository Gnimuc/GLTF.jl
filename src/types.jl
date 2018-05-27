abstract type AbstractExtension end


mutable struct Asset
    copyright::Union{Nothing,String}
    generator::Union{Nothing,String}
    version::String
    minVersion::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Asset() = Asset(nothing, nothing, "", nothing, nothing, nothing)
JSON2.@format Asset noargs

mutable struct Buffer
    uri::Union{Nothing,String}
    byteLength::Cuint
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Buffer() = Buffer(nothing, 1, nothing, nothing, nothing)
JSON2.@format Buffer noargs

mutable struct BufferView
    buffer::Cuint
    byteOffset::Union{Nothing,Cuint}
    byteLength::Cuint
    byteStride::Union{Nothing,Cuint}
    target::Union{Nothing,Cuint}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
BufferView() = BufferView(0, 0, 1, nothing, nothing, nothing, nothing, nothing)
JSON2.@format BufferView noargs


mutable struct Indices
    bufferView::Cuint
    byteOffset::Union{Nothing,Cuint}
    componentType::Cuint
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Indices() = Indices(0, 0, 0, nothing, nothing)
JSON2.@format Indices noargs

mutable struct Values
    bufferView::Cuint
    byteOffset::Union{Nothing,Cuint}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Values() = Values(0, 0, nothing, nothing)
JSON2.@format Values noargs

mutable struct Sparse
    count::Cuint
    indices::Indices
    values::Values
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Sparse() = Sparse(0, Indices(), Values(), nothing, nothing)
JSON2.@format Sparse noargs

mutable struct Accessor
    bufferView::Union{Nothing,Cuint}
    byteOffset::Union{Nothing,Cuint}
    componentType::Cuint
    normalized::Union{Nothing,Bool}
    count::Cuint
    _type::String
    max::Union{Nothing,Vector{Cfloat}}
    min::Union{Nothing,Vector{Cfloat}}
    sparse::Union{Nothing,Sparse}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Accessor() = Accessor(nothing, 0, 0, false, 1, "", nothing, nothing, nothing, nothing, nothing, nothing)
JSON2.@format Accessor noargs

mutable struct Target
    node::Union{Nothing,Cuint}
    path::String
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Target() = Target(nothing, "", nothing, nothing)
JSON2.@format Target noargs

mutable struct Channel
    sampler::Cuint
    target::Target
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Channel() = Channel(0, Target(), nothing, nothing)
JSON2.@format Channel noargs

mutable struct AnimationSampler
    input::Cuint
    interpolation::Union{Nothing,String}
    output::Cuint
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
AnimationSampler() = AnimationSampler(0, "LINEAR", 0, nothing, nothing)
JSON2.@format AnimationSampler noargs

mutable struct Animation
    channels::Vector{Channel}
    samplers::Vector{AnimationSampler}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Animation() = Animation([Channel()], [AnimationSampler()], nothing, nothing, nothing)
JSON2.@format Animation noargs

mutable struct Orthographic
    xmag::Cfloat
    ymag::Cfloat
    zfar::Cfloat
    znear::Cfloat
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Orthographic() = Orthographic(1, 1, 1000, 0, nothing, nothing)
JSON2.@format Orthographic noargs

mutable struct Perspective
    aspectRatio::Union{Nothing,Cfloat}
    yfov::Cfloat
    zfar::Union{Nothing,Cfloat}
    znear::Cfloat
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Perspective() = Perspective(nothing, deg2rad(67), nothing, 0, nothing, nothing)
JSON2.@format Perspective noargs

mutable struct Camera
    orthographic::Union{Nothing,Orthographic}
    perspective::Union{Nothing,Perspective}
    _type::String
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Camera() = Camera(nothing, nothing, "", nothing, nothing, nothing)
JSON2.@format Camera noargs

mutable struct Image
    uri::Union{Nothing,String}
    mimeType::Union{Nothing,String}
    bufferView::Union{Nothing,Cuint}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Image() = Image(nothing, nothing, nothing, nothing, nothing, nothing)
JSON2.@format Image noargs

mutable struct TextureInfo
    index::Cuint
    texCoord::Union{Nothing,Cuint}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
TextureInfo() = TextureInfo(0, 0, nothing, nothing)
JSON2.@format TextureInfo noargs

mutable struct NormalTextureInfo
    index::Cuint
    texCoord::Union{Nothing,Cuint}
    scale::Union{Nothing,Cfloat}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
NormalTextureInfo() = NormalTextureInfo(0, 0, 1, nothing, nothing)
JSON2.@format NormalTextureInfo noargs

mutable struct OcclusionTextureInfo
    index::Cuint
    texCoord::Union{Nothing,Cuint}
    strength::Union{Nothing,Cfloat}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
OcclusionTextureInfo() = OcclusionTextureInfo(0, 0, 1, nothing, nothing)
JSON2.@format OcclusionTextureInfo noargs

mutable struct PBRMetallicRoughness
    baseColorFactor::Union{Nothing,Vector{Cfloat}}
    baseColorTexture::Union{Nothing,TextureInfo}
    metallicFactor::Union{Nothing,Cfloat}
    roughnessFactor::Union{Nothing,Cfloat}
    metallicRoughnessTexture::Union{Nothing,TextureInfo}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
PBRMetallicRoughness() = PBRMetallicRoughness([1,1,1,1], nothing, 1, 1, nothing, nothing, nothing)
JSON2.@format PBRMetallicRoughness noargs

mutable struct Material
    pbrMetallicRoughness::Union{Nothing,PBRMetallicRoughness}
    normalTexture::Union{Nothing,NormalTextureInfo}
    occlusionTexture::Union{Nothing,OcclusionTextureInfo}
    emissiveTexture::Union{Nothing,TextureInfo}
    emissiveFactor::Union{Nothing,Vector{Cfloat}}
    alphaMode::Union{Nothing,String}
    alphaCutoff::Union{Nothing,Cfloat}
    doubleSided::Union{Nothing,Bool}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Material() = Material(nothing, nothing, nothing, nothing, [0,0,0], "OPAQUE", 0.5, false, nothing, nothing, nothing)
JSON2.@format Material noargs

mutable struct Primitive
    attributes::Dict{String,Cuint}
    indices::Union{Nothing,Cuint}
    material::Union{Nothing,Cuint}
    mode::Union{Nothing,Cuint}
    targets::Union{Nothing,Vector}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Primitive() = Primitive(Dict(""=>0), nothing, nothing, 4, nothing, nothing, nothing)
JSON2.@format Primitive noargs

mutable struct Mesh
    primitives::Vector{Primitive}
    weights::Union{Nothing,Vector{Cfloat}}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Mesh() = Mesh([Primitive()], nothing, nothing, nothing, nothing)
JSON2.@format Mesh noargs

mutable struct Node
    camera::Union{Nothing,Cuint}
    children::Union{Nothing,Vector{Cuint}}
    skin::Union{Nothing,Cuint}
    matrix::Union{Nothing,Vector{Cfloat}}
    mesh::Union{Nothing,Cuint}
    rotation::Union{Nothing,Vector{Cfloat}}
    scale::Union{Nothing,Vector{Cfloat}}
    translation::Union{Nothing,Vector{Cfloat}}
    weights::Union{Nothing,Vector{Cfloat}}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Node() = Node(nothing, nothing, nothing, [1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1], nothing,
              [0,0,0,1], [1,1,1], [0,0,0], nothing, nothing, nothing, nothing)
JSON2.@format Node noargs

mutable struct Sampler
    magFilter::Union{Nothing,Cuint}
    minFilter::Union{Nothing,Cuint}
    wrapS::Union{Nothing,Cuint}
    wrapT::Union{Nothing,Cuint}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Sampler() = Sampler(nothing, nothing, 10497, 10497, nothing, nothing, nothing)
JSON2.@format Sampler noargs

mutable struct Scene
    nodes::Union{Nothing,Vector{Cuint}}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Scene() = Scene(nothing, nothing, nothing, nothing)
JSON2.@format Scene noargs

mutable struct Skin
    inverseBindMatrices::Union{Nothing,Cuint}
    skeleton::Union{Nothing,Cuint}
    joints::Vector{Cuint}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Skin() = Skin(nothing, nothing, [0], nothing, nothing, nothing)
JSON2.@format Skin noargs

mutable struct Texture
    sampler::Union{Nothing,Cuint}
    source::Union{Nothing,Cuint}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Texture() = Texture(nothing, nothing, nothing, nothing, nothing)
JSON2.@format Texture noargs

mutable struct Root
    accessors::Union{Nothing,Vector{Accessor}}
    animations::Union{Nothing,Vector{Animation}}
    asset::Asset
    buffers::Union{Nothing,Vector{Buffer}}
    bufferViews::Union{Nothing,Vector{BufferView}}
    cameras::Union{Nothing,Vector{Camera}}
    images::Union{Nothing,Vector{Image}}
    materials::Union{Nothing,Vector{Material}}
    meshes::Union{Nothing,Vector{Mesh}}
    nodes::Union{Nothing,Vector{Node}}
    samplers::Union{Nothing,Vector{Sampler}}
    scene::Union{Nothing,Cuint}
    scenes::Union{Nothing,Vector{Scene}}
    skins::Union{Nothing,Vector{Skin}}
    textures::Union{Nothing,Vector{Texture}}
    extensionsUsed::Union{Nothing,Set{String}}
    extensionsRequired::Union{Nothing,Set{String}}
    extensions::Union{Nothing,Set{AbstractExtension}}
    extras
end
Root() = Root(nothing, nothing, Asset(), nothing, nothing, nothing, nothing,
              nothing, nothing, nothing, nothing, nothing, nothing, nothing,
              nothing, nothing, nothing, nothing, nothing)
JSON2.@format Root noargs
