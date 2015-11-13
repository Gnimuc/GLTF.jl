# GLTF

[![Build Status](https://travis-ci.org/Gnimuc/GLTF.jl.svg?branch=master)](https://travis-ci.org/Gnimuc/GLTF.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/3f32qqywxtcghh2f?svg=true)](https://ci.appveyor.com/project/Gnimuc/gltf-jl)
[![codecov.io](https://codecov.io/github/Gnimuc/GLTF.jl/coverage.svg?branch=master)](https://codecov.io/github/Gnimuc/GLTF.jl?branch=master)

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
