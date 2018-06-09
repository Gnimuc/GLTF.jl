mutable struct BufferView
    buffer::Int
    byteOffset::Union{Nothing,Int}
    byteLength::Int
    byteStride::Union{Nothing,Int}
    target::Union{Nothing,Int}
    name::Union{Nothing,String}
    extensions::Dict
    extras
    function BufferView(; buffer, byteLength, byteOffset=nothing, target=nothing, byteStride=nothing, name=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        buffer ≥ 0 || throw(ArgumentError("the index of the buffer should be ≥ 0"))
        byteLength ≥ 1 || throw(ArgumentError("byteLength should be ≥ 1"))
        obj.buffer = buffer
        obj.byteLength = byteLength
        if byteOffset != nothing
            byteOffset ≥ 0 || throw(ArgumentError("byteOffset should be ≥ 0"))
            obj.byteOffset = byteOffset
        end
        if target != nothing
            target == ARRAY_BUFFER ||
            target == ELEMENT_ARRAY_BUFFER || throw(ArgumentError("target should be ARRAY_BUFFER(34962) or ELEMENT_ARRAY_BUFFER(34963)"))
            obj.target = target
        end
        if byteStride != nothing
            4 ≤ byteStride ≤ 252 || throw(ArgumentError("byteStride should be ≥ 4 and ≤ 252"))
            obj.byteStride = byteStride
        end
        name == nothing || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format BufferView keywordargs begin
    byteOffset => (omitempty=true,)
    byteStride => (omitempty=true,)
    target => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
