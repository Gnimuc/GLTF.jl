mutable struct Texture
    sampler::Union{Nothing,Int}
    source::Union{Nothing,Int}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Texture()
        obj = new()
        obj.sampler = nothing
        obj.source = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.setproperty!(obj::Texture, sym::Symbol, x)
    if sym === :sampler && x !== nothing
        x ≥ 0 || throw(ArgumentError("the index of the sampler used by this texture should be ≥ 0"))
    elseif sym === :source && x !== nothing
        source ≥ 0 || throw(ArgumentError("the index of the image used by this texture should be ≥ 0"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Texture}) = JSON3.Mutable()
JSON3.omitempties(::Type{Texture}) = (:sampler, :source, :name, :extensions, :extras)
