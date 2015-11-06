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
```

>GLTF.GLTFBufferView(GLTF.GLTFBuffer("vertices.bin",1024,"arraybuffer",Nullable("user-defined buffer name"),Nullable(Dict{AbstractString,Any}("extension_name"=>Dict{AbstractString,Any}("extension specific"=>"value"))),Dict{AbstractString,Any}("Application specific"=>"The extra object can contain any properties.")),0,76768,Nullable(34962),Nullable("user-defined name of bufferView with vertices"),Nullable(Dict{AbstractString,Any}("extension_name"=>Dict{AbstractString,Any}("extension specific"=>"value"))),Dict{AbstractString,Any}("Application specific"=>"The extra object can contain any properties."))

Note that, the corresponding `buffer` has already been nested in `bufferView`, not just its `id`(a not so much helpful string).

## License
MIT except one test file: `example.gltf` which is released under [BSD](https://github.com/KhronosGroup/glTF/blob/9c7dbd3bf4eea36cc91638d441a7c7b059af6417/LICENSE.md).
