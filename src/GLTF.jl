module GLTF

using JSON3

export load, save

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

function load(path::AbstractString)
    open(path) do f
        JSON3.read(read(f, String), Object)
    end
end

function save(path::AbstractString, obj::Object)
    open(path, write=true) do f
        write(f, JSON3.write(obj))
    end
end



end # module
