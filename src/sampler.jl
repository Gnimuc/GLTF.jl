mutable struct Sampler
    magFilter::Union{Nothing,Int}
    minFilter::Union{Nothing,Int}
    wrapS::Union{Nothing,Int}
    wrapT::Union{Nothing,Int}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Sampler()
        obj = new()
        obj.magFilter = nothing
        obj.minFilter = nothing
        obj.wrapS = nothing
        obj.wrapT = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::Sampler, sym::Symbol)
    x = getfield(obj, sym)
    sym === :wrapS && x === nothing && return 10497
    sym === :wrapT && x === nothing && return 10497
    return x
end

function Base.setproperty!(obj::Sampler, sym::Symbol, x)
    if sym === :magFilter && x !== nothing
        x === NEAREST || x === LINEAR ||
            throw(ArgumentError("magFilter should be one of: NEAREST(9728), LINEAR(9729)"))
    elseif sym === :minFilter && x !== nothing
        x === NEAREST || x === LINEAR || x === NEAREST_MIPMAP_NEAREST ||
        x === LINEAR_MIPMAP_NEAREST || x === NEAREST_MIPMAP_LINEAR || x === LINEAR_MIPMAP_LINEAR ||
            throw(ArgumentError("minFilter should be one of: NEAREST(9728), LINEAR(9729), NEAREST_MIPMAP_NEAREST(9984), LINEAR_MIPMAP_NEAREST(9985), NEAREST_MIPMAP_LINEAR(9986), LINEAR_MIPMAP_LINEAR(9987)"))
    elseif sym === :wrapS && x !== nothing
        x === CLAMP_TO_EDGE || x === MIRRORED_REPEAT || x === REPEAT ||
            throw(ArgumentError("wrapS should be one of: CLAMP_TO_EDGE(33071), MIRRORED_REPEAT(33648), REPEAT(10497)"))
    elseif sym === :wrapT && x !== nothing
        x === CLAMP_TO_EDGE || x === MIRRORED_REPEAT || x === REPEAT ||
            throw(ArgumentError("wrapT should be one of: CLAMP_TO_EDGE(33071), MIRRORED_REPEAT(33648), REPEAT(10497)"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Sampler}) = JSON3.Mutable()
JSON3.omitempties(::Type{Sampler}) = (:magFilter, :minFilter, :wrapS, :wrapT, :name, :extensions, :extras)
