mutable struct Image
    uri::String
    mimeType::String
    bufferView::Int
    name::String
    extensions::Dict
    extras
    function Image(; uri="", mimeType="", bufferView=-1, name="", extensions=Dict(), extras=nothing)
        obj = new()
        uri == "" || (obj.uri = uri;)
        if mimeType != ""
            mimeType == "image/jpeg" ||
            mimeType == "image/png" || throw(ArgumentError("""the image's MIME type should be "image/jpeg" or "image/png" """))
            obj.mimeType = mimeType
        end
        if bufferView != -1
            bufferView ≥ 0 || throw(ArgumentError("the index of the bufferView that contains the image should be ≥ 0"))
            obj.bufferView = bufferView
        end
        name == "" || (obj.name = name;)
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
