mutable struct Asset
    copyright::Union{Nothing,String}
    generator::Union{Nothing,String}
    version::String
    minVersion::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Asset()
        obj = new()
        obj.copyright = nothing
        obj.generator = nothing
        obj.minVersion = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

JSON3.StructType(::Type{Asset}) = JSON3.Mutable()
JSON3.omitempties(::Type{Asset}) = (:copyright, :generator, :minVersion, :extensions, :extras)
