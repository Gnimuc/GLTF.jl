module GLTF

using JSON3

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
include("show.jl")

mutable struct GLTFData
    extensionsUsed::Union{Nothing,Vector{String}}
    extensionsRequired::Union{Nothing,Vector{String}}
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
    scene::Union{Nothing,Int}
    scenes::Union{Nothing,Vector{Scene}}
    skins::Union{Nothing,Vector{Skin}}
    textures::Union{Nothing,Vector{Texture}}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function GLTFData()
        obj = new()
        obj.extensionsUsed = nothing
        obj.extensionsRequired = nothing
        obj.accessors = nothing
        obj.animations = nothing
        obj.buffers = nothing
        obj.bufferViews = nothing
        obj.cameras = nothing
        obj.images = nothing
        obj.materials = nothing
        obj.meshes = nothing
        obj.nodes = nothing
        obj.samplers = nothing
        obj.scene = nothing
        obj.scenes = nothing
        obj.skins = nothing
        obj.textures = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

JSON3.StructType(::Type{GLTFData}) = JSON3.Mutable()
JSON3.omitempties(::Type{GLTFData}) = (:extensionsUsed, :extensionsRequired, :accessors, :animations,
                                       :buffers, :bufferViews, :cameras, :images, :materials, :meshes,
                                       :nodes, :samplers, :scene, :scenes, :skins, :textures, :extensions, :extras)

function Base.show(io::IO, ::MIME"text/plain", x::GLTFData)
    print(io, GLTFData, ":")
    for name in fieldnames(GLTFData)
        isdefined(x, name) || continue
        v = getfield(x, name)
        v != nothing && print(io, "\n  $name: ", v)
    end
end


end # module
