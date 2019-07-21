mutable struct Object
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
