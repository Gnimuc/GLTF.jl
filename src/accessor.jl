mutable struct Indices
    bufferView::Int
    byteOffset::Union{Nothing,Int}
    componentType::Int
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Indices()
        obj = new()
        obj.byteOffset = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::Indices, sym::Symbol)
    x = getfield(obj, sym)
    sym === :byteOffset && x === nothing && return 0
    return x
end

function Base.setproperty!(obj::Indices, sym::Symbol, x)
    if sym === :bufferView
        x ≥ 0 || throw(ArgumentError("the index of the bufferView should be ≥ 0"))
    elseif sym === :byteOffset && x !== nothing
        x ≥ 0 || throw(ArgumentError("byteOffset should be ≥ 0"))
    elseif sym === :componentType
        x === UNSIGNED_BYTE || x === UNSIGNED_SHORT || x === UNSIGNED_INT ||
            throw(ArgumentError("componentType should be one of: UNSIGNED_BYTE(5121), UNSIGNED_SHORT(5123), UNSIGNED_INT(5125)"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Indices}) = JSON3.Mutable()
JSON3.omitempties(::Type{Indices}) = (:byteOffset, :extensions, :extras)

mutable struct Values
    bufferView::Int
    byteOffset::Union{Nothing,Int}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Values()
        obj = new()
        obj.byteOffset = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::Values, sym::Symbol)
    x = getfield(obj, sym)
    sym === :byteOffset && x === nothing && return 0
    return x
end

function Base.setproperty!(obj::Values, sym::Symbol, x)
    if sym === :bufferView
        x ≥ 0 || throw(ArgumentError("the index of the bufferView should be ≥ 0"))
    elseif sym === :byteOffset && x !== nothing
        x ≥ 0 || throw(ArgumentError("byteOffset should be ≥ 0"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Values}) = JSON3.Mutable()
JSON3.omitempties(::Type{Values}) = (:byteOffset, :extensions, :extras)

mutable struct Sparse
    count::Int
    indices::Indices
    values::Values
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Sparse()
        obj = new()
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.setproperty!(obj::Sparse, sym::Symbol, x)
    if sym === :count
        x ≥ 1 || throw(ArgumentError("the number of attributes encoded in this sparse accessor should be ≥ 1"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Sparse}) = JSON3.Mutable()
JSON3.omitempties(::Type{Sparse}) = (:extensions, :extras)

mutable struct Accessor
    bufferView::Union{Nothing,Int}
    byteOffset::Union{Nothing,Int}
    componentType::Int
    normalized::Union{Nothing,Bool}
    count::Int
    type::String
    max::Union{Nothing,Vector}
    min::Union{Nothing,Vector}
    sparse::Union{Nothing,Sparse}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Accessor()
        obj = new()
        obj.bufferView = nothing
        obj.byteOffset = nothing
        obj.normalized = nothing
        obj.max = nothing
        obj.min = nothing
        obj.sparse = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::Accessor, sym::Symbol)
    x = getfield(obj, sym)
    sym === :byteOffset && x === nothing && return 0
    sym === :normalized && x === nothing && return false
    return x
end

function Base.setproperty!(obj::Accessor, sym::Symbol, x)
    if sym === :bufferView && x !== nothing
        x ≥ 0 || throw(ArgumentError("the index of the bufferView should be ≥ 0"))
    elseif sym === :byteOffset && x !== nothing
        x ≥ 0 || throw(ArgumentError("byteOffset should be ≥ 0"))
    elseif sym === :componentType
        x === BYTE || x === UNSIGNED_BYTE || x === SHORT ||
        x === UNSIGNED_SHORT || x === UNSIGNED_INT || x === FLOAT ||
            throw(ArgumentError("componentType should be one of: BYTE(5120), UNSIGNED_BYTE(5121), SHORT(5122), UNSIGNED_SHORT(5123), UNSIGNED_INT(5125), FLOAT(5126)"))
    elseif sym === :count
        x ≥ 1 || throw(ArgumentError("the number of attributes referenced by this accessor should be ≥ 1"))
    elseif sym === :type
        x === "SCALAR" ||
        x === "VEC2" || x === "VEC3" || x === "VEC4" ||
        x === "MAT2" || x === "MAT3" || x === "MAT4" ||
            throw(ArgumentError("""type should be one of: "SCALAR", "VEC2", "VEC3", "VEC4", "MAT2", "MAT3", "MAT4" """))
    elseif sym === :max && x !== nothing
        len = length(x)
        len === 1 || len === 2 || len === 3 || len === 4 || len === 9 || len === 16 ||
            throw(ArgumentError("""the length should be one of: 1, 2, 3, 4, 9, 16 """))
    elseif sym === :min && x !== nothing
        len = length(x)
        len === 1 || len === 2 || len === 3 || len === 4 || len === 9 || len === 16 ||
            throw(ArgumentError("""the length should be one of: 1, 2, 3, 4, 9, 16 """))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Accessor}) = JSON3.Mutable()
JSON3.omitempties(::Type{Accessor}) = (:bufferView, :byteOffset, :normalized, :max, :min, :sparse, :name, :extensions, :extras)
