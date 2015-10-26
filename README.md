# GLTF

## WIP
glTF2.0 has been released for a while, it looks like it will be frequently updating in the long ran, I guess it's the right time to write a generator. thanks to Julia's metaprogramming, it's not gonna be convoluted. I'm doing some reworking in the `rebuild` branch. (looks like the way to represent missing values(`Nullable`) will be changed: https://github.com/JuliaLang/julia/issues/22682, maybe I need to wait a while and do more investigation)

## Installation
`Pkg.clone("https://github.com/Gnimuc/GLTF.jl.git")`

## Examples:
```julia
using GLTF, JSON

rootDict = JSON.parsefile("example.gltf")
bufferView = GLTF.loadbufferview("vertices_id", rootDict)
GLTFBufferView:
  buffer: GLTFBuffer
    uri: vertices.bin
    byteLength: 1024
    _type: arraybuffer
    name: Nullable("user-defined buffer name")
    extensions: Nullable(Dict{AbstractString,Any}("extension_name"=>Dict{AbstractString,Any}("extension specific"=>"value")))
    extras: Dict{AbstractString,Any}("Application specific"=>"The extra object can contain any properties.")
  byteOffset: 0
  byteLength: 76768
  target: Nullable(34962)
  name: Nullable("user-defined name of bufferView with vertices")
  extensions: Nullable(Dict{AbstractString,Any}("extension_name"=>Dict{AbstractString,Any}("extension specific"=>"value")))
  extras: Dict{AbstractString,Any}("Application specific"=>"The extra object can contain any properties.")
```
Note that, the corresponding `buffer` has already been nested in the `bufferView` object, not just its `id`(a not so much helpful string).

## Use Cases
My particular use case is to load partial of a big glTF file, e.g. a buffer view object or a texture object. Currently, this package also provides some "God-loaders" such as `GLTF.load()`, `GLTF.loadscene()` and `GLTF.loadnode()`. I highly recommend to avoid using those loaders, because they are very slow and not well implemented.

## TODO List
- [ ] make this package compatible with [ModernGL.jl](https://github.com/JuliaGL/ModernGL.jl)

## License
MIT except one test file: `example.gltf` which is released under [BSD](https://github.com/KhronosGroup/glTF/blob/9c7dbd3bf4eea36cc91638d441a7c7b059af6417/LICENSE.md).
