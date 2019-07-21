mutable struct Orthographic
    xmag::Cfloat
    ymag::Cfloat
    zfar::Cfloat
    znear::Cfloat
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Orthographic()
        obj = new()
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.setproperty!(obj::Orthographic, sym::Symbol, x)
    if sym === :zfar
        x > 0 || throw(ArgumentError("the distance to the far clipping plane should be > 0"))
    elseif sym === :znear
        x ≥ 0 || throw(ArgumentError("the distance to the near clipping plane should be ≥ 0"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Orthographic}) = JSON3.Mutable()
JSON3.omitempties(::Type{Orthographic}) = (:extensions, :extras)


mutable struct Perspective
    aspectRatio::Union{Nothing,Cfloat}
    yfov::Cfloat
    zfar::Union{Nothing,Cfloat}
    znear::Cfloat
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Perspective()
        obj = new()
        obj.aspectRatio = nothing
        obj.zfar = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.setproperty!(obj::Perspective, sym::Symbol, x)
    if sym === :aspectRatio && x !== nothing
        x > 0 || throw(ArgumentError("the aspect ratio of the field of view should be > 0"))
    elseif sym === :yfov
        x > 0 || throw(ArgumentError("the vertical field of view in radians should be > 0"))
    elseif sym === :zfar && x !== nothing
        x > 0 || throw(ArgumentError("the distance to the far clipping plane should be > 0"))
    elseif sym === :znear
        x > 0 || throw(ArgumentError("the distance to the near clipping plane should be > 0"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Perspective}) = JSON3.Mutable()
JSON3.omitempties(::Type{Perspective}) = (:aspectRatio, :zfar, :extensions, :extras)


mutable struct Camera
    orthographic::Union{Nothing,Orthographic}
    perspective::Union{Nothing,Perspective}
    type::String
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Camera()
        obj = new()
        obj.orthographic = nothing
        obj.perspective = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.setproperty!(obj::Camera, sym::Symbol, x)
    if sym === :type
        x == "perspective" || x == "orthographic" ||
            throw(ArgumentError("""type should be "perspective" or "orthographic" """))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Camera}) = JSON3.Mutable()
JSON3.omitempties(::Type{Camera}) = (:orthographic, :perspective, :name, :extensions, :extras)
