mutable struct Skin
    inverseBindMatrices::Union{Nothing,Int}
    skeleton::Union{Nothing,Int}
    joints::Vector{Int}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Skin()
        obj = new()
        obj.inverseBindMatrices = nothing
        obj.skeleton = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.setproperty!(obj::Skin, sym::Symbol, x)
    if sym === :inverseBindMatrices && x !== nothing
        x ≥ 0 || throw(ArgumentError("the index of the accessor containing the inverse-bind matrices should be ≥ 0"))
    elseif sym === :skeleton && x !== nothing
        skeleton ≥ 0 || throw(ArgumentError("the index of the node used as a skeleton root should be ≥ 0"))
    elseif sym === :joints
        isempty(x) && throw(ArgumentError("joints should not be empty."))
        allunique(x) || throw(ArgumentError("joint number must be unique."))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Skin}) = JSON3.Mutable()
StructTypes.omitempties(::Type{Skin}) = (:inverseBindMatrices, :skeleton, :name, :extensions, :extras)
