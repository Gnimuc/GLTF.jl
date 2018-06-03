mutable struct Target
    node::Int
    path::String
    extensions::Dict
    extras
    function Target(path; node=-1, extensions=Dict(), extras=nothing)
        obj = new()
        path == "translation" ||
        path == "rotation" ||
        path == "scale" ||
        path == "weights" || throw(ArgumentError("""path should be one of: "translation", "rotation", "scale", "weights" """))
        obj.path = path
        if node != -1
            node < 0 && throw(ArgumentError("the index of the node to target should be ≥ 0"))
            obj.node = node
        end
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
Target(; path="", node=-1, extensions=Dict(), extras=nothing) = Target(path, node=node, extensions=extensions, extras=extras)
JSON2.@format Target keywordargs begin
    node => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct Channel
    sampler::Int
    target::Target
    extensions::Dict
    extras
    function Channel(sampler, target; extensions=Dict(), extras=nothing)
        obj = new()
        sampler < 0 && throw(ArgumentError("the index of a sampler used to compute the value for the target should be ≥ 0"))
        obj.sampler = sampler
        obj.target = target
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
Channel(; sampler=-1, target=Target(), extensions=Dict(), extras=nothing) = Channel(sampler, target, extensions=extensions, extras=extras)
JSON2.@format Channel keywordargs begin
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct AnimationSampler
    input::Int
    interpolation::String
    output::Int
    extensions::Dict
    extras
    function AnimationSampler(input, output; interpolation="", extensions=Dict(), extras=nothing)
        obj = new()
        input < 0 && throw(ArgumentError("the index of an accessor containing keyframe input values should be ≥ 0"))
        output < 0 && throw(ArgumentError("the index of an accessor containing keyframe output values should be ≥ 0"))
        obj.input = input
        obj.output = output
        if interpolation != ""
            interpolation == "LINEAR" ||
            interpolation == "STEP" ||
            interpolation == "CUBICSPLINE" || throw(ArgumentError("""interpolation should be one of: "LINEAR", "STEP", "CUBICSPLINE" """))
            obj.interpolation = interpolation
        end
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
AnimationSampler(; input=-1, output=-1, interpolation="", extensions=Dict(), extras=nothing) = AnimationSampler(input, output, interpolation=interpolation, extensions=extensions, extras=extras)
JSON2.@format AnimationSampler keywordargs begin
    interpolation => (omitempty=true, default="LINEAR")
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end

mutable struct Animation
    channels::Vector{Channel}
    samplers::Vector{AnimationSampler}
    name::String
    extensions::Dict
    extras
    function Animation(channels, samplers; name="", extensions=Dict(), extras=nothing)
        isempty(channels) && throw(ArgumentError("channels should not be empty"))
        isempty(samplers) && throw(ArgumentError("samplers should not be empty"))
        obj = new(channels, samplers)
        name == "" || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
Animation(; channels=[], samplers=[], name="", extensions=Dict(), extras=nothing) = Animation(channels, samplers, name=name, extensions=extensions, extras=extras)
JSON2.@format Animation keywordargs begin
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
