mutable struct Asset
    copyright::Union{Nothing,String}
    generator::Union{Nothing,String}
    version::String
    minVersion::Union{Nothing,String}
    extensions::Dict
    extras
    function Asset(; version, copyright=nothing, generator=nothing, minVersion=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        obj.version = version
        copyright == nothing || (obj.copyright = copyright;)
        generator == nothing || (obj.generator = generator;)
        minVersion == nothing || (obj.minVersion = minVersion;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Asset keywordargs begin
    copyright => (omitempty=true,)
    generator => (omitempty=true,)
    minVersion => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
