mutable struct Asset
    copyright::String
    generator::String
    version::String
    minVersion::String
    extensions::Dict
    extras
    function Asset(version; copyright="", generator="", minVersion="", extensions=Dict(), extras=nothing)
        obj = new()
        version == "" && throw(ArgumentError("glTF version is missing"))
        obj.version = version
        copyright == "" || (obj.copyright = copyright;)
        generator == "" || (obj.generator = generator;)
        minVersion == "" || (obj.minVersion = minVersion;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
Asset(; copyright="", generator="", version="", minVersion="", extensions=Dict(),
    extras=nothing) = Asset(version, copyright=copyright, generator=generator, minVersion=minVersion, extensions=extensions, extras=extras)
JSON2.@format Asset keywordargs begin
    copyright => (omitempty=true,)
    generator => (omitempty=true,)
    minVersion => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
