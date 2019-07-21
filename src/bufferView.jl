mutable struct BufferView
    buffer::Int
    byteOffset::Union{Nothing,Int}
    byteLength::Int
    byteStride::Union{Nothing,Int}
    target::Union{Nothing,Int}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function BufferView()
        obj = new()
        obj.byteOffset = nothing
        obj.byteStride = nothing
        obj.target = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::BufferView, sym::Symbol)
    x = getfield(obj, sym)
    sym === :byteOffset && x === nothing && return 0
    return x
end

function Base.setproperty!(obj::BufferView, sym::Symbol, x)
    if sym === :buffer
        x ≥ 0 || throw(ArgumentError("the index of the buffer should be ≥ 0"))
    elseif sym === :byteOffset && x !== nothing
        x ≥ 0 || throw(ArgumentError("byteOffset should be ≥ 0"))
    elseif sym === :byteLength
        x ≥ 1 || throw(ArgumentError("byteLength should be ≥ 1"))
    elseif sym === :byteStride && x !== nothing
        4 ≤ x ≤ 252 || throw(ArgumentError("byteStride should be ≥ 4 and ≤ 252"))
    elseif sym === :target && x !== nothing
        x === ARRAY_BUFFER || x === ELEMENT_ARRAY_BUFFER ||
            throw(ArgumentError("target should be ARRAY_BUFFER(34962) or ELEMENT_ARRAY_BUFFER(34963)"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{BufferView}) = JSON3.Mutable()
JSON3.omitempties(::Type{BufferView}) = (:byteOffset, :byteStride, :target, :name, :extensions, :extras)
