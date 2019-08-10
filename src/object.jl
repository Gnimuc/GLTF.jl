mutable struct Object
    extensionsUsed::Union{Nothing,Vector{String}}
    extensionsRequired::Union{Nothing,Vector{String}}
    accessors::Union{Nothing,ZVector{Accessor}}
    animations::Union{Nothing,ZVector{Animation}}
    asset::Asset
    buffers::Union{Nothing,ZVector{Buffer}}
    bufferViews::Union{Nothing,ZVector{BufferView}}
    cameras::Union{Nothing,ZVector{Camera}}
    images::Union{Nothing,ZVector{Image}}
    materials::Union{Nothing,ZVector{Material}}
    meshes::Union{Nothing,ZVector{Mesh}}
    nodes::Union{Nothing,ZVector{Node}}
    samplers::Union{Nothing,ZVector{Sampler}}
    scene::Union{Nothing,Int}
    scenes::Union{Nothing,ZVector{Scene}}
    skins::Union{Nothing,ZVector{Skin}}
    textures::Union{Nothing,ZVector{Texture}}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Object()
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

JSON3.StructType(::Type{Object}) = JSON3.Mutable()
JSON3.omitempties(::Type{Object}) = (:extensionsUsed, :extensionsRequired, :accessors, :animations,
                                     :buffers, :bufferViews, :cameras, :images, :materials, :meshes,
                                     :nodes, :samplers, :scene, :scenes, :skins, :textures, :extensions, :extras)
