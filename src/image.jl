mutable struct Image
    uri::Union{Nothing,String}
    mimeType::Union{Nothing,String}
    bufferView::Union{Nothing,Int}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Image()
        obj = new()
        obj.uri = nothing
        obj.mimeType = nothing
        obj.bufferView = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.setproperty!(obj::Image, sym::Symbol, x)
    if sym === :mimeType && x !== nothing
        x == "image/jpeg" || x == "image/png" ||
            throw(ArgumentError("""the image's MIME type should be "image/jpeg" or "image/png" """))
    elseif sym === :bufferView && x !== nothing
        x ≥ 0 || throw(ArgumentError("the index of the bufferView that contains the image should be ≥ 0"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Image}) = JSON3.Mutable()
JSON3.omitempties(::Type{Image}) = (:uri, :mimeType, :bufferView, :name, :extensions, :extras)
