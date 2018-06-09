# __precompile__(true)
module GLTF

using JSON2

# constants
const ARRAY_BUFFER = 34962
const ELEMENT_ARRAY_BUFFER = 34963

const BYTE = 5120
const UNSIGNED_BYTE = 5121
const SHORT = 5122
const UNSIGNED_SHORT = 5123
const UNSIGNED_INT = 5125
const FLOAT = 5126

const POINTS = 0
const LINES = 1
const LINE_LOOP = 2
const LINE_STRIP = 3
const TRIANGLES = 4
const TRIANGLE_STRIP = 5
const TRIANGLE_FAN = 6

const NEAREST = 9728
const LINEAR = 9729
const NEAREST_MIPMAP_NEAREST = 9984
const LINEAR_MIPMAP_NEAREST = 9985
const NEAREST_MIPMAP_LINEAR = 9986
const LINEAR_MIPMAP_LINEAR = 9987
const CLAMP_TO_EDGE = 33071
const MIRRORED_REPEAT = 33648
const REPEAT = 10497

# types
include("accessor.jl")
include("animation.jl")
include("asset.jl")
include("buffer.jl")
include("bufferView.jl")
include("camera.jl")
include("image.jl")
include("material.jl")
include("mesh.jl")
include("node.jl")
include("sampler.jl")
include("scene.jl")
include("skin.jl")
include("texture.jl")


mutable struct RootObject
    accessors::Vector{Accessor}
    animations::Vector{Animation}
    asset::Asset
    buffers::Vector{Buffer}
    bufferViews::Vector{BufferView}
    cameras::Vector{Camera}
    images::Vector{Image}
    materials::Vector{Material}
    meshes::Vector{Mesh}
    nodes::Vector{Node}
    samplers::Vector{Sampler}
    scene::Union{Nothing,Int}
    scenes::Vector{Scene}
    skins::Vector{Skin}
    textures::Vector{Texture}
    extensionsUsed::Set{String}
    extensionsRequired::Set{String}
    extensions::Dict
    extras
    function RootObject(; asset, accessors=[], animations=[], buffers=[], bufferViews=[], cameras=[],
        images=[], materials=[], meshes=[], nodes=[], samplers=[], scene=nothing, scenes=[], skins=[],
        textures=[], extensionsUsed=Set(), extensionsRequired=Set(), extensions=Dict(), extras=nothing)
        obj = new()
        obj.asset = asset
        isempty(accessors) || (obj.accessors = accessors;)
        isempty(animations) || (obj.animations = animations;)
        isempty(buffers) || (obj.buffers = buffers;)
        isempty(bufferViews) || (obj.bufferViews = bufferViews;)
        isempty(cameras) || (obj.cameras = cameras;)
        isempty(images) || (obj.images = images;)
        isempty(materials) || (obj.materials = materials;)
        isempty(meshes) || (obj.meshes = meshes;)
        isempty(nodes) || (obj.nodes = nodes;)
        isempty(samplers) || (obj.samplers = samplers;)
        if scene != nothing
            scene ≥ 0 || throw(ArgumentError("the index of the default scene should be ≥ 0"))
            obj.scene = scene
        end
        isempty(scenes) || (obj.scenes = scenes;)
        isempty(skins) || (obj.skins = skins;)
        isempty(textures) || (obj.textures = textures;)
        isempty(extensionsUsed) || (obj.extensionsUsed = extensionsUsed;)
        isempty(extensionsRequired) || (obj.extensionsRequired = extensionsRequired;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format RootObject keywordargs begin
    accessors => (omitempty=true,)
    animations => (omitempty=true,)
    buffers => (omitempty=true,)
    bufferViews => (omitempty=true,)
    cameras => (omitempty=true,)
    images => (omitempty=true,)
    materials => (omitempty=true,)
    meshes => (omitempty=true,)
    nodes => (omitempty=true,)
    samplers => (omitempty=true,)
    scene => (omitempty=true,)
    scenes => (omitempty=true,)
    skins => (omitempty=true,)
    textures => (omitempty=true,)
    extensionsUsed => (omitempty=true,)
    extensionsRequired => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


end # module
