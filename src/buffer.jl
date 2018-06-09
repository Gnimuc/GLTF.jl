mutable struct Buffer
    uri::Union{Nothing,String}
    byteLength::Int
    name::Union{Nothing,String}
    extensions::Dict
    extras
    function Buffer(; byteLength, uri=nothing, name=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        byteLength ≥ 1 || throw(ArgumentError("byteLength should be ≥ 1"))
        obj.byteLength = byteLength
        uri == nothing || (obj.uri = uri;)
        name == nothing || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Buffer keywordargs begin
    uri => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
