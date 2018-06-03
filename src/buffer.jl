mutable struct Buffer
    uri::String
    byteLength::Int
    name::String
    extensions::Dict
    extras
    function Buffer(byteLength; uri="", name="", extensions=Dict(), extras=nothing)
        obj = new()
        byteLength ≥ 1 || throw(ArgumentError("byteLength should be ≥ 1"))
        obj.byteLength = byteLength
        uri == "" || (obj.uri = uri;)
        name == "" || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
Buffer(; uri="", byteLength=1, name="", extensions=Dict(),
    extras=nothing) = Buffer(byteLength, uri=uri, name=name, extensions=extensions, extras=extras)
JSON2.@format Buffer keywordargs begin
    uri => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
