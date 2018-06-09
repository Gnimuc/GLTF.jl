mutable struct Node
    camera::Union{Nothing,Int}
    children::Set{Int}
    skin::Union{Nothing,Int}
    matrix::Vector{Int}
    mesh::Union{Nothing,Int}
    rotation::Vector{Cfloat}
    scale::Vector{Cfloat}
    translation::Vector{Cfloat}
    weights::Vector{Cfloat}
    name::Union{Nothing,String}
    extensions::Dict
    extras
    function Node(; camera=nothing, children=Set(), skin=nothing, matrix=[], mesh=nothing, rotation=[],
                    scale=[], translation=[], weights=[], name=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        if camera != nothing
            camera ≥ 0 || throw(ArgumentError("the index of the camera referenced by this node should be ≥ 0"))
            obj.camera = camera
        end
        if !isempty(children)
            all(c ≥ 0 for c in children) || throw(ArgumentError("the indices of this node's children should be ≥ 0"))
            obj.children = children
        end
        if skin != nothing
            skin ≥ 0 || throw(ArgumentError("the index of the skin referenced by this node should be ≥ 0"))
            obj.skin = skin
        end
        if !isempty(matrix)
            length(matrix) == 16 || throw(ArgumentError("the length of transformation matrix should be exactly 16"))
            obj.matrix = matrix
        end
        if mesh != nothing
            mesh ≥ 0 || throw(ArgumentError("the index of the mesh in this node should be ≥ 0"))
            obj.mesh = mesh
        end
        if !isempty(rotation)
            all(-1 .≤ rotation .≤ 1) || throw(ArgumentError("each element in the unit quaternion rotation should be ≥ -1 and ≤ 1"))
            obj.rotation = rotation
        end
        if !isempty(scale)
            length(scale) == 3 || throw(ArgumentError("the length of scale should be exactly 3"))
            obj.scale = scale
        end
        if !isempty(translation)
            length(translation) == 3 || throw(ArgumentError("the length of translation should be exactly 3"))
            obj.translation = translation
        end
        isempty(weights) || (obj.weights = weights;)
        name == nothing || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Node keywordargs begin
    camera => (omitempty=true,)
    children => (omitempty=true,)
    skin => (omitempty=true,)
    matrix => (omitempty=true,)
    mesh => (omitempty=true,)
    rotation => (omitempty=true,)
    scale => (omitempty=true,)
    translation => (omitempty=true,)
    weights => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
