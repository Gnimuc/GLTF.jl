mutable struct BufferView
    buffer::Int
    byteOffset::Int
    byteLength::Int
    byteStride::Int
    target::Int
    name::String
    extensions::Dict
    extras
    function BufferView(buffer, byteLength; byteOffset=-1, target=-1, byteStride=-1, name="", extensions=Dict(), extras=nothing)
        obj = new()
        buffer ≥ 0 || throw(ArgumentError("the index of the buffer should be ≥ 0"))
        byteLength ≥ 1 || throw(ArgumentError("byteLength should be ≥ 1"))
        obj.buffer = buffer
        obj.byteLength = byteLength
        if byteOffset != -1
            byteOffset ≥ 0 || throw(ArgumentError("byteOffset should be ≥ 0"))
            obj.byteOffset = byteOffset
        end
        if target != -1
            target == ARRAY_BUFFER ||
            target == ELEMENT_ARRAY_BUFFER || throw(ArgumentError("target should be ARRAY_BUFFER(34962) or ELEMENT_ARRAY_BUFFER(34963)"))
            obj.target = target
        end
        if byteStride != -1
            4 ≤ byteStride ≤ 252 || throw(ArgumentError("byteStride should be ≥ 4 and ≤ 252"))
            obj.byteStride = byteStride
        end
        name == "" || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
BufferView(; buffer=-1, byteOffset=-1, byteLength=-1, byteStride=-1, target=-1,
    name="", extensions=Dict(), extras=nothing) = BufferView(buffer, byteLength, byteOffset=byteOffset, target=target, byteStride=byteStride,
                                                             name=name, extensions=extensions, extras=extras)
JSON2.@format BufferView keywordargs begin
    byteOffset => (omitempty=true, default=0)
    byteStride => (omitempty=true,)
    target => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
