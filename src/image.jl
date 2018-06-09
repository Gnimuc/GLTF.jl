mutable struct Image
    uri::Union{Nothing,String}
    mimeType::Union{Nothing,String}
    bufferView::Union{Nothing,Int}
    name::Union{Nothing,String}
    extensions::Dict
    extras
    function Image(; uri=nothing, mimeType=nothing, bufferView=nothing, name=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        uri == nothing || (obj.uri = uri;)
        if mimeType != nothing
            mimeType == "image/jpeg" ||
            mimeType == "image/png" || throw(ArgumentError("""the image's MIME type should be "image/jpeg" or "image/png" """))
            obj.mimeType = mimeType
        end
        if bufferView != nothing
            bufferView ≥ 0 || throw(ArgumentError("the index of the bufferView that contains the image should be ≥ 0"))
            obj.bufferView = bufferView
        end
        name == nothing || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Image keywordargs begin
    uri => (omitempty=true,)
    mimeType => (omitempty=true,)
    bufferView => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
