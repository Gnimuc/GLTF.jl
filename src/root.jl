mutable struct RootObject
    accessors::Vector{Accessor}
    animations::Vector{Animation}
    asset::Asset
    buffers::Vector{Buffer}
    bufferViews::Vector{BufferView}
    cameras::Vector{Camera}
    images::Vector{Image}
    materials::Vector{Material}
    meshes::Vector{Mesh}
    nodes::Vector{Node}
    samplers::Vector{Sampler}
    scene::Union{Nothing,Int}
    scenes::Vector{Scene}
    skins::Vector{Skin}
    textures::Vector{Texture}
    extensionsUsed::Set{String}
    extensionsRequired::Set{String}
    extensions::Dict
    extras
    function RootObject(; asset, accessors=[], animations=[], buffers=[], bufferViews=[], cameras=[],
        images=[], materials=[], meshes=[], nodes=[], samplers=[], scene=nothing, scenes=[], skins=[],
        textures=[], extensionsUsed=Set(), extensionsRequired=Set(), extensions=Dict(), extras=nothing)
        obj = new()
        obj.asset = asset
        isempty(accessors) || (obj.accessors = accessors;)
        isempty(animations) || (obj.animations = animations;)
        isempty(buffers) || (obj.buffers = buffers;)
        isempty(bufferViews) || (obj.bufferViews = bufferViews;)
        isempty(cameras) || (obj.cameras = cameras;)
        isempty(images) || (obj.images = images;)
        isempty(materials) || (obj.materials = materials;)
        isempty(meshes) || (obj.meshes = meshes;)
        isempty(nodes) || (obj.nodes = nodes;)
        isempty(samplers) || (obj.samplers = samplers;)
        if scene != nothing
            scene ≥ 0 || throw(ArgumentError("the index of the default scene should be ≥ 0"))
            obj.scene = scene
        end
        isempty(scenes) || (obj.scenes = scenes;)
        isempty(skins) || (obj.skins = skins;)
        isempty(textures) || (obj.textures = textures;)
        isempty(extensionsUsed) || (obj.extensionsUsed = extensionsUsed;)
        isempty(extensionsRequired) || (obj.extensionsRequired = extensionsRequired;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format RootObject keywordargs begin
    accessors => (omitempty=true,)
    animations => (omitempty=true,)
    buffers => (omitempty=true,)
    bufferViews => (omitempty=true,)
    cameras => (omitempty=true,)
    images => (omitempty=true,)
    materials => (omitempty=true,)
    meshes => (omitempty=true,)
    nodes => (omitempty=true,)
    samplers => (omitempty=true,)
    scene => (omitempty=true,)
    scenes => (omitempty=true,)
    skins => (omitempty=true,)
    textures => (omitempty=true,)
    extensionsUsed => (omitempty=true,)
    extensionsRequired => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
