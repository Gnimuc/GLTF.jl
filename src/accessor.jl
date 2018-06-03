mutable struct Indices
    bufferView::Int
    byteOffset::Int
    componentType::Int
    extensions::Dict
    extras
    function Indices(bufferView, componentType; byteOffset=-1, extensions=Dict(), extras=nothing)
        obj = new()
        bufferView ≥ 0 || throw(ArgumentError("the index of the bufferView should be ≥ 0"))
        componentType == UNSIGNED_BYTE ||
        componentType == UNSIGNED_SHORT ||
        componentType == UNSIGNED_INT || throw(ArgumentError("componentType should be one of: UNSIGNED_BYTE(5121), UNSIGNED_SHORT(5123), UNSIGNED_INT(5125)"))
        obj.bufferView = bufferView
        obj.componentType = componentType
        if byteOffset != -1
            byteOffset ≥ 0 || throw(ArgumentError("byteOffset should be ≥ 0"))
            obj.byteOffset = byteOffset
        end
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
Indices(; bufferView=-1, byteOffset=-1, componentType=-1,
    extensions=Dict(), extras=nothing) = Indices(bufferView, componentType, byteOffset=byteOffset,
                                                 extensions=extensions, extras=extras)
JSON2.@format Indices keywordargs begin
    byteOffset => (omitempty=true, default=0)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct Values
    bufferView::Int
    byteOffset::Int
    extensions::Dict
    extras
    function Values(bufferView; byteOffset=-1, extensions=Dict(), extras=nothing)
        obj = new()
        bufferView ≥ 0 || throw(ArgumentError("the index of the bufferView should be ≥ 0"))
        obj.bufferView = bufferView
        if byteOffset != -1
            byteOffset ≥ 0 || throw(ArgumentError("byteOffset should be ≥ 0"))
            obj.byteOffset = byteOffset
        end
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
Values(; bufferView=-1, byteOffset=-1, extensions=Dict(), extras=nothing) = Values(bufferView, byteOffset=byteOffset, extensions=extensions, extras=extras)
JSON2.@format Values keywordargs begin
    byteOffset => (omitempty=true, default=0)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct Sparse
    count::Int
    indices::Indices
    values::Values
    extensions::Dict
    extras
    function Sparse(count, indices, values; extensions=Dict(), extras=nothing)
        obj = new()
        count ≥ 1 || throw(ArgumentError("the number of attributes encoded in this sparse accessor should be ≥ 1"))
        obj.indices = indices
        obj.values = values
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
Sparse(; count=-1, indices=Indices(), values=Values(), extensions=Dict(), extras=nothing) = Sparse(count, indices, values, extensions=extensions, extras=extras)
JSON2.@format Sparse keywordargs begin
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct Accessor
    bufferView::Int
    byteOffset::Int
    componentType::Int
    normalized::Bool
    count::Int
    _type::String
    max::Vector{Cfloat}
    min::Vector{Cfloat}
    sparse::Union{Nothing,Sparse}
    name::String
    extensions::Dict
    extras
    function Accessor(componentType, count, _type; bufferView=-1, byteOffset=-1, normalized=false,
                      max=[], min=[], sparse=nothing, name="", extensions=Dict(), extras=nothing)
        obj = new()
        componentType == BYTE ||
        componentType == UNSIGNED_BYTE ||
        componentType == SHORT ||
        componentType == UNSIGNED_SHORT ||
        componentType == UNSIGNED_INT ||
        componentType == FLOAT || throw(ArgumentError("componentType should be one of: BYTE(5120), UNSIGNED_BYTE(5121), SHORT(5122), UNSIGNED_SHORT(5123), UNSIGNED_INT(5125), FLOAT(5126)"))
        count ≥ 1 || throw(ArgumentError("the number of attributes referenced by this accessor should be ≥ 1"))
        _type == "SCALAR" ||
        _type == "VEC2" ||
        _type == "VEC3" ||
        _type == "VEC4" ||
        _type == "MAT2" ||
        _type == "MAT3" ||
        _type == "MAT4" || throw(ArgumentError("""type should be one of: "SCALAR", "VEC2", "VEC3", "VEC4", "MAT2", "MAT3", "MAT4" """))
        obj.componentType = componentType
        obj.count = count
        obj._type = _type
        if bufferView != -1
            bufferView ≥ 0 || throw(ArgumentError("the index of the bufferView should be ≥ 0"))
            obj.bufferView = bufferView
        end
        if byteOffset != -1
            byteOffset ≥ 0 || throw(ArgumentError("byteOffset should be ≥ 0"))
            obj.byteOffset = byteOffset
        end
        normalized && (obj.normalized = normalized;)
        isempty(max) || (obj.max = max;)
        isempty(min) || (obj.min = min;)
        sparse != nothing && (obj.sparse = sparse;)
        name == "" || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
Accessor(; componentType=-1, count=-1, _type="", bufferView=-1, byteOffset=-1, normalized=false, max=[], min=[], sparse=nothing,
    name="", extensions=Dict(), extras=nothing) = Accessor(componentType, count, _type, bufferView=bufferView, byteOffset=byteOffset, normalized=normalized,
                                                           max=max, min=min, sparse=sparse, name=name, extensions=extensions, extras=extras)
JSON2.@format Accessor keywordargs begin
    bufferView => (omitempty=true,)
    byteOffset => (omitempty=true, default=0)
    normalized => (omitempty=true, default=false)
    max => (omitempty=true,)
    min => (omitempty=true,)
    sparse => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
