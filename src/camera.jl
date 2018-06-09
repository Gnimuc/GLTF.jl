mutable struct Orthographic
    xmag::Cfloat
    ymag::Cfloat
    zfar::Cfloat
    znear::Cfloat
    extensions::Dict
    extras
    function Orthographic(; xmag, ymag, zfar, znear, extensions=Dict(), extras=nothing)
        obj = new(xmag, ymag)
        (zfar > 0 && zfar > znear) || throw(ArgumentError("zfar should be > 0 and must be ≥ znear"))
        znear ≥ 0 || throw(ArgumentError("znear should be ≥ 0"))
        obj.zfar = zfar
        obj.znear = znear
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Orthographic keywordargs begin
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct Perspective
    aspectRatio::Union{Nothing,Cfloat}
    yfov::Cfloat
    zfar::Union{Nothing,Cfloat}
    znear::Cfloat
    extensions::Dict
    extras
    function Perspective(; yfov, znear, aspectRatio=nothing, zfar=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        yfov > 0 || throw(ArgumentError("the vertical field of view in radians should be > 0"))
        znear > 0 || throw(ArgumentError("the distance to the near clipping plane should be > 0"))
        obj.yfov = yfov
        obj.znear = znear
        if aspectRatio != nothing
            aspectRatio > 0 || throw(ArgumentError("aspectRatio should be > 0"))
            obj.aspectRatio = aspectRatio
        end
        if zfar != nothing
            (zfar > 0 && zfar > znear) || throw(ArgumentError("zfar should be > 0 and must be ≥ znear"))
            obj.zfar = zfar
        end
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Perspective keywordargs begin
    aspectRatio => (omitempty=true,)
    zfar => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct Camera
    orthographic::Union{Nothing,Orthographic}
    perspective::Union{Nothing,Perspective}
    _type::String
    name::Union{Nothing,String}
    extensions::Dict
    extras
    function Camera(; _type, orthographic=nothing, perspective=nothing, name=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        _type == "perspective" ||
        _type == "orthographic" || throw(ArgumentError("""type should be "perspective" or "orthographic" """))
        obj._type = _type
        orthographic != nothing && (obj.orthographic = orthographic;)
        perspective != nothing && (obj.perspective = perspective;)
        name == nothing || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Camera keywordargs begin
    orthographic => (omitempty=true,)
    perspective => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
