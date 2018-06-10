__precompile__(true)
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
include("root.jl")
include("show.jl")




end # module
