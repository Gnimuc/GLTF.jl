mutable struct Buffer
    uri::Union{Nothing,String}
    byteLength::Int
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Buffer()
        obj = new()
        obj.uri = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.setproperty!(obj::Buffer, sym::Symbol, x)
    if sym === :byteLength
        x ≥ 1 || throw(ArgumentError("byteLength should be ≥ 1"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Buffer}) = JSON3.Mutable()
StructTypes.omitempties(::Type{Buffer}) = (:uri, :name, :extensions, :extras)
