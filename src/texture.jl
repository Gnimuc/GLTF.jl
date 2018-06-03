mutable struct Texture
    sampler::Int
    source::Int
    name::String
    extensions::Dict
    extras
    function Texture(; sampler=-1, source=-1, name="", extensions=Dict(), extras=nothing)
        obj = new()
        if sampler != -1
            sampler ≥ 0 || throw(ArgumentError("the index of the sampler used by this texture should be ≥ 0"))
            obj.sampler = sampler
        end
        if source != -1
            source ≥ 0 || throw(ArgumentError("the index of the image used by this texture should be ≥ 0"))
            obj.source = source
        end
        name == "" || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Texture keywordargs begin
    sampler => (omitempty=true,)
    source => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
