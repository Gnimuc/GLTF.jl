module GLTF

using JSON, StructUtils, PrecompileTools

export load, save

# Preserve JSON3/StructTypes per-field omission behavior during serialization.
function _lower_omitting(x, omitted)
    names = fieldnames(typeof(x))
    (; (name => getfield(x, name) for name in names if
        isdefined(x, name) && !(name in omitted && _json_empty(getfield(x, name))))...)
end

_json_empty(x) = x === nothing || (x isa Union{AbstractArray, AbstractDict, AbstractString} && isempty(x))

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

include("zvector.jl")
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
include("object.jl")
include("show.jl")

const GLTFMutable = Union{
    Indices, Values, Sparse, Accessor, Target, Channel, AnimationSampler,
    Animation, Asset, Buffer, BufferView, Orthographic, Perspective, Camera,
    Image, TextureInfo, NormalTextureInfo, OcclusionTextureInfo,
    PBRMetallicRoughness, Material, Primitive, Mesh, Node, Sampler, Scene,
    Skin, Texture, Object,
}
StructUtils.noarg(::Type{T}) where {T<:GLTFMutable} = true

function load(path::AbstractString)
    open(path) do f
        JSON.parse(read(f, String), Object)
    end
end

function save(path::AbstractString, obj::Object)
    open(path, write=true) do f
        write(f, JSON.json(obj))
    end
end

@compile_workload begin
    filenames = ["DamagedHelmet.gltf"]
    for filename in filenames
        path = joinpath(pkgdir(GLTF), "assets", filename)
        asset = load(path)::Object
        sprint(show, asset)
        sprint(show, MIME"text/plain"(), asset)
        tmp = tempname()
        save(tmp, asset)
        load(tmp)::Object
        rm(tmp)
    end
end

end # module
