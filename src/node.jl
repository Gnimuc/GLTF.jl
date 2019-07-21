mutable struct Node
    camera::Union{Nothing,Int}
    children::Union{Nothing,Vector{Int}}
    skin::Union{Nothing,Int}
    matrix::Union{Nothing,Vector{Cfloat}}
    mesh::Union{Nothing,Int}
    rotation::Union{Nothing,Vector{Cfloat}}
    scale::Union{Nothing,Vector{Cfloat}}
    translation::Union{Nothing,Vector{Cfloat}}
    weights::Union{Nothing,Vector{Cfloat}}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Node()
        obj = new()
        obj.camera = nothing
        obj.children = nothing
        obj.skin = nothing
        obj.matrix = nothing
        obj.mesh = nothing
        obj.rotation = nothing
        obj.scale = nothing
        obj.translation = nothing
        obj.weights = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::Node, sym::Symbol)
    x = getfield(obj, sym)
    sym === :matrix && x === nothing && return Cfloat[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1]
    sym === :rotation && x === nothing && return Cfloat[0,0,0,1]
    sym === :scale && x === nothing && return Cfloat[1,1,1]
    sym === :translation && x === nothing && return Cfloat[0,0,0]
    return x
end

function Base.setproperty!(obj::Node, sym::Symbol, x)
    if sym === :camera && x !== nothing
        x ≥ 0 || throw(ArgumentError("the index of the camera referenced by this node should be ≥ 0"))
    elseif sym === :children && x !== nothing
        all(c->c ≥ 0, x) || throw(ArgumentError("the indices of this node's children should be ≥ 0"))
        allunique(x) || throw(ArgumentError("children must be unique."))
    elseif sym === :skin && x !== nothing
        x ≥ 0 || throw(ArgumentError("the index of the skin referenced by this node should be ≥ 0"))
    elseif sym === :matrix && x !== nothing
        length(x) == 16 || throw(ArgumentError("the length of matrix should be exactly 16"))
    elseif sym === :mesh && x !== nothing
        x ≥ 0 || throw(ArgumentError("the index of the mesh in this node should be ≥ 0"))
    elseif sym === :rotation && x !== nothing
        length(x) == 4 || throw(ArgumentError("the length of rotation should be exactly 4"))
        all(-1 .≤ x .≤ 1) || throw(ArgumentError("each element in the unit quaternion rotation should be ≥ -1 and ≤ 1"))
    elseif sym === :scale && x !== nothing
        length(x) == 3 || throw(ArgumentError("the length of scale should be exactly 3"))
    elseif sym === :translation && x !== nothing
        length(x) == 3 || throw(ArgumentError("the length of translation should be exactly 3"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Node}) = JSON3.Mutable()
JSON3.omitempties(::Type{Node}) = (:camera, :children, :skin, :matrix, :mesh, :rotation, :scale, :translation, :weights, :name, :extensions, :extras)
