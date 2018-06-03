mutable struct Sampler
    magFilter::Int
    minFilter::Int
    wrapS::Int
    wrapT::Int
    name::String
    extensions::Dict
    extras
    function Sampler(; magFilter=-1, minFilter=-1, wrapS=-1, wrapT=-1, name="", extensions=Dict(), extras=nothing)
        obj = new()
        if magFilter != -1
            magFilter == NEAREST || magFilter == LINEAR || throw(ArgumentError("magFilter should be one of: NEAREST(9728), LINEAR(9729)"))
            obj.magFilter = magFilter
        end
        if minFilter != -1
            minFilter == NEAREST ||
            minFilter == LINEAR ||
            minFilter == NEAREST_MIPMAP_NEAREST ||
            minFilter == LINEAR_MIPMAP_NEAREST ||
            minFilter == NEAREST_MIPMAP_LINEAR ||
            minFilter == LINEAR_MIPMAP_LINEAR || throw(ArgumentError("minFilter should be one of: NEAREST(9728), LINEAR(9729), NEAREST_MIPMAP_NEAREST(9984), LINEAR_MIPMAP_NEAREST(9985), NEAREST_MIPMAP_LINEAR(9986), LINEAR_MIPMAP_LINEAR(9987)"))
            obj.minFilter = minFilter
        end
        if wrapS != -1
            wrapS == CLAMP_TO_EDGE ||
            wrapS == MIRRORED_REPEAT ||
            wrapS == REPEAT || throw(ArgumentError("wrapS should be one of: CLAMP_TO_EDGE(33071), MIRRORED_REPEAT(33648), REPEAT(10497)"))
            obj.wrapS = wrapS
        end
        if wrapT != -1
            wrapT == CLAMP_TO_EDGE ||
            wrapT == MIRRORED_REPEAT ||
            wrapT == REPEAT || throw(ArgumentError("wrapT should be one of: CLAMP_TO_EDGE(33071), MIRRORED_REPEAT(33648), REPEAT(10497)"))
            obj.wrapT = wrapT
        end
        name == "" || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Sampler keywordargs begin
    magFilter => (omitempty=true,)
    minFilter => (omitempty=true,)
    wrapS => (omitempty=true, default=10497)
    wrapT => (omitempty=true, default=10497)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
