mutable struct Scene
    nodes::Union{Nothing,Vector{Int}}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Scene(; nodes=Set(), name=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        obj.nodes = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.setproperty!(obj::Scene, sym::Symbol, x)
    if sym === :nodes && x !== nothing
        all(n->n ≥ 0, x) || throw(ArgumentError("the indices of each root node should be ≥ 0"))
        allunique(x) || throw(ArgumentError("nodes must be unique."))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Scene}) = JSON3.Mutable()
JSON3.omitempties(::Type{Scene}) = (:nodes, :name, :extensions, :extras)
