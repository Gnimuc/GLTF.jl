# GLTF

[![Build Status](https://travis-ci.org/Gnimuc/GLTF.jl.svg?branch=master)](https://travis-ci.org/Gnimuc/GLTF.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/Gnimuc/GLTF.jl?svg=true)](https://ci.appveyor.com/project/Gnimuc/GLTF-jl)
[![Codecov](https://codecov.io/gh/Gnimuc/GLTF.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/Gnimuc/GLTF.jl)

[glTF](https://github.com/KhronosGroup/glTF) 2.0 loader and writer based on [JSON3](https://github.com/quinnj/JSON3.jl).

## Installation
```julia
pkg> add GLTF
```

## Usage
glTF file format is just a JSON file + raw binaries. This package defines Julia types that map to the corresponding glTF objects. 

```julia
julia> using JSON3, GLTF

julia> accessor_str = """{
         "bufferView": 0,
         "componentType": 5126,
         "count": 24,
         "type": "VEC3",
         "max": [
           0.3,
           0.3,
           0.3
         ],
         "min": [
           -0.3,
           -0.3,
           -0.3
         ],
         "name": "Positions Accessor"
       }"""
"{\n  \"bufferView\": 0,\n  \"componentType\": 5126,\n  \"count\": 24,\n  \"type\": \"VEC3\",\n  \"max\": [\n    0.3,\n    0.3,\n    0.3\n  ],\n  \"min\": [\n    -0.3,\n    -0.3,\n    -0.3\n  ],\n  \"name\": \"Positions Accessor\"\n}"

julia> accessor = JSON3.read(accessor_str, GLTF.Accessor)
GLTF.Accessor:
  bufferView: 0
  componentType: 5126
  count: 24
  type: VEC3
  max: Any[0.3, 0.3, 0.3]
  min: Any[-0.3, -0.3, -0.3]
  name: Positions Accessor
```

load/save file from/to disk:
```
load("path/to/xxx.gltf") # -> GLTF.Object
save("path/to/xxx.gltf", x) # where x is of type GLTF.Object
```
