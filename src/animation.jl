mutable struct Target
    node::Union{Nothing,Int}
    path::String
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Target()
        obj = new()
        obj.node = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.setproperty!(obj::Target, sym::Symbol, x)
    if sym === :node && x !== nothing
        x ≥ 0 || throw(ArgumentError("the index of the node to target should be ≥ 0"))
    elseif sym === :path
        x === "translation" || x === "rotation" || x === "scale" || x === "weights" ||
            throw(ArgumentError("""path should be one of: "translation", "rotation", "scale", "weights" """))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Target}) = JSON3.Mutable()
JSON3.omitempties(::Type{Target}) = (:node, :extensions, :extras)


mutable struct Channel
    sampler::Int
    target::Target
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Channel()
        obj = new()
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.setproperty!(obj::Channel, sym::Symbol, x)
    if sym === :sampler
        x ≥ 0 || throw(ArgumentError("the index of a sampler used to compute the value for the target should be ≥ 0"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Channel}) = JSON3.Mutable()
JSON3.omitempties(::Type{Channel}) = (:extensions, :extras)


mutable struct AnimationSampler
    input::Int
    interpolation::Union{Nothing,String}
    output::Int
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function AnimationSampler()
        obj = new()
        obj.interpolation = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::AnimationSampler, sym::Symbol)
    x = getfield(obj, sym)
    sym === :interpolation && x === nothing && return "LINEAR"
    return x
end

function Base.setproperty!(obj::AnimationSampler, sym::Symbol, x)
    if sym === :input
        x ≥ 0 || throw(ArgumentError("the index of an accessor containing keyframe input values should be ≥ 0"))
    elseif sym === :interpolation && x !== nothing
        x === "LINEAR" || x === "STEP" || x === "CUBICSPLINE" ||
            throw(ArgumentError("""interpolation should be one of: "LINEAR", "STEP", "CUBICSPLINE" """))
    elseif sym === :output
        x ≥ 0 || throw(ArgumentError("the index of an accessor containing keyframe output values should be ≥ 0"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{AnimationSampler}) = JSON3.Mutable()
JSON3.omitempties(::Type{AnimationSampler}) = (:interpolation, :extensions, :extras)


mutable struct Animation
    channels::ZVector{Channel}
    samplers::ZVector{AnimationSampler}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Animation()
        obj = new()
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

JSON3.StructType(::Type{Animation}) = JSON3.Mutable()
JSON3.omitempties(::Type{Animation}) = (:name, :extensions, :extras)
