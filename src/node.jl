mutable struct Node
    camera::Int
    children::Set{Int}
    skin::Int
    matrix::Vector{Int}
    mesh::Int
    rotation::Vector{Cfloat}
    scale::Vector{Cfloat}
    translation::Vector{Cfloat}
    weights::Vector{Cfloat}
    name::String
    extensions::Dict
    extras
    function Node(; camera=-1, children=Set(), skin=-1, matrix=[], mesh=-1, rotation=[], scale=[],
                    translation=[], weights=[], name="", extensions=Dict(), extras=nothing)
        obj = new()
        if camera != -1
            camera ≥ 0 || throw(ArgumentError("the index of the camera referenced by this node should be ≥ 0"))
            obj.camera = camera
        end
        if !isempty(children)
            all(c ≥ 0 for c in children) || throw(ArgumentError("the indices of this node's children should be ≥ 0"))
            obj.children = children
        end
        if skin != -1
            skin ≥ 0 || throw(ArgumentError("the index of the skin referenced by this node should be ≥ 0"))
            obj.skin = skin
        end
        if !isempty(matrix)
            length(matrix) == 16 || throw(ArgumentError("the length of transformation matrix should be exactly 16"))
            obj.matrix = matrix
        end
        if mesh != -1
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
        name == "" || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Node keywordargs begin
    camera => (omitempty=true,)
    children => (omitempty=true,)
    skin => (omitempty=true,)
    matrix => (omitempty=true, default=[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1])
    mesh => (omitempty=true,)
    rotation => (omitempty=true, default=[0,0,0,1])
    scale => (omitempty=true, default=[1,1,1])
    translation => (omitempty=true, default=[0,0,0])
    weights => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
