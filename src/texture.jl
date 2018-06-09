mutable struct Texture
    sampler::Union{Nothing,Int}
    source::Union{Nothing,Int}
    name::Union{Nothing,String}
    extensions::Dict
    extras
    function Texture(; sampler=nothing, source=nothing, name=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        if sampler != nothing
            sampler ≥ 0 || throw(ArgumentError("the index of the sampler used by this texture should be ≥ 0"))
            obj.sampler = sampler
        end
        if source != nothing
            source ≥ 0 || throw(ArgumentError("the index of the image used by this texture should be ≥ 0"))
            obj.source = source
        end
        name == nothing || (obj.name = name;)
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
