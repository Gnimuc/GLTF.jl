mutable struct TextureInfo
    index::Int
    texCoord::Union{Nothing,Int}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function TextureInfo()
        obj = new()
        obj.texCoord = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::TextureInfo, sym::Symbol)
    x = getfield(obj, sym)
    sym === :texCoord && x === nothing && return 0
    return x
end

function Base.setproperty!(obj::TextureInfo, sym::Symbol, x)
    if sym === :index
        x ≥ 0 || throw(ArgumentError("the index of the texture should be ≥ 0"))
    elseif sym === :texCoord && x !== nothing
        x ≥ 0 || throw(ArgumentError("the set index of texture's TEXCOORD attribute used for texture coordinate mapping should be ≥ 0"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{TextureInfo}) = JSON3.Mutable()
JSON3.omitempties(::Type{TextureInfo}) = (:texCoord, :extensions, :extras)


mutable struct NormalTextureInfo
    index::Int
    texCoord::Union{Nothing,Int}
    scale::Union{Nothing,Cfloat}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function NormalTextureInfo()
        obj = new()
        obj.texCoord = nothing
        obj.scale = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::NormalTextureInfo, sym::Symbol)
    x = getfield(obj, sym)
    sym === :texCoord && x === nothing && return 0
    sym === :scale && x === nothing && return 1
    return x
end

function Base.setproperty!(obj::NormalTextureInfo, sym::Symbol, x)
    if sym === :index
        x ≥ 0 || throw(ArgumentError("the index of the texture should be ≥ 0"))
    elseif sym === :texCoord && x !== nothing
        x ≥ 0 || throw(ArgumentError("the set index of texture's TEXCOORD attribute used for texture coordinate mapping should be ≥ 0"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{NormalTextureInfo}) = JSON3.Mutable()
JSON3.omitempties(::Type{NormalTextureInfo}) = (:texCoord, :scale, :extensions, :extras)


mutable struct OcclusionTextureInfo
    index::Int
    texCoord::Union{Nothing,Int}
    strength::Union{Nothing,Cfloat}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function OcclusionTextureInfo()
        obj = new()
        obj.texCoord = nothing
        obj.strength = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::OcclusionTextureInfo, sym::Symbol)
    x = getfield(obj, sym)
    sym === :texCoord && x === nothing && return 0
    sym === :strength && x === nothing && return 1
    return x
end

function Base.setproperty!(obj::OcclusionTextureInfo, sym::Symbol, x)
    if sym === :index
        x ≥ 0 || throw(ArgumentError("the index of the texture should be ≥ 0"))
    elseif sym === :texCoord && x !== nothing
        x ≥ 0 || throw(ArgumentError("the set index of texture's TEXCOORD attribute used for texture coordinate mapping should be ≥ 0"))
    elseif sym === :strength && x !== nothing
        0 ≤ strength ≤ 1 || throw(ArgumentError("strength should be should be ≥ 0 and ≤ 1"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{OcclusionTextureInfo}) = JSON3.Mutable()
JSON3.omitempties(::Type{OcclusionTextureInfo}) = (:texCoord, :strength, :extensions, :extras)


mutable struct PBRMetallicRoughness
    baseColorFactor::Union{Nothing,Vector{Cfloat}}
    baseColorTexture::Union{Nothing,TextureInfo}
    metallicFactor::Union{Nothing,Cfloat}
    roughnessFactor::Union{Nothing,Cfloat}
    metallicRoughnessTexture::Union{Nothing,TextureInfo}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function PBRMetallicRoughness()
        obj = new()
        obj.baseColorFactor = nothing
        obj.baseColorTexture = nothing
        obj.metallicFactor = nothing
        obj.roughnessFactor = nothing
        obj.metallicRoughnessTexture = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::PBRMetallicRoughness, sym::Symbol)
    x = getfield(obj, sym)
    sym === :baseColorFactor && x === nothing && return Cfloat[1,1,1,1]
    sym === :metallicFactor && x === nothing && return 1
    sym === :roughnessFactor && x === nothing && return 1
    return x
end

function Base.setproperty!(obj::PBRMetallicRoughness, sym::Symbol, x)
    if sym === :baseColorFactor && x !== nothing
        length(x) == 4 || throw(ArgumentError("the material's base color factor should exactly contain 4 values(RGBA)"))
        all(0 .≤ x .≤ 1) || throw(ArgumentError("the material's base color factor value should ≥ 0 and ≤ 1"))
    elseif sym === :metallicFactor && x !== nothing
        0 ≤ x ≤ 1 || throw(ArgumentError("the metalness of the material factor should ≥ 0 and ≤ 1"))
    elseif sym === :roughnessFactor && x !== nothing
        0 ≤ roughnessFactor ≤ 1 || throw(ArgumentError("the roughness of the material factor should ≥ 0 and ≤ 1"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{PBRMetallicRoughness}) = JSON3.Mutable()
JSON3.omitempties(::Type{PBRMetallicRoughness}) = (:baseColorFactor, :baseColorTexture, :metallicFactor, :roughnessFactor, :metallicRoughnessTexture, :extensions, :extras)


mutable struct Material
    pbrMetallicRoughness::Union{Nothing,PBRMetallicRoughness}
    normalTexture::Union{Nothing,NormalTextureInfo}
    occlusionTexture::Union{Nothing,OcclusionTextureInfo}
    emissiveTexture::Union{Nothing,TextureInfo}
    emissiveFactor::Union{Nothing,Vector{Cfloat}}
    alphaMode::Union{Nothing,String}
    alphaCutoff::Union{Nothing,Cfloat}
    doubleSided::Union{Nothing,Bool}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Material()
        obj = new()
        obj.pbrMetallicRoughness = nothing
        obj.normalTexture = nothing
        obj.occlusionTexture = nothing
        obj.emissiveTexture = nothing
        obj.emissiveFactor = nothing
        obj.alphaMode = nothing
        obj.alphaCutoff = nothing
        obj.doubleSided = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::Material, sym::Symbol)
    x = getfield(obj, sym)
    sym === :emissiveFactor && x === nothing && return Cfloat[0,0,0]
    sym === :alphaMode && x === nothing && return "OPAQUE"
    sym === :alphaCutoff && x === nothing && return 0.5
    sym === :doubleSided && x === nothing && return false
    return x
end

function Base.setproperty!(obj::Material, sym::Symbol, x)
    if sym === :emissiveFactor && x !== nothing
        length(x) == 3 || throw(ArgumentError("the RGB components of the emissive color of the material should exactly contain 3 values"))
        all(0 .≤ x .≤ 1) || throw(ArgumentError("the emissive color should be ≥ 0 and ≤ 1"))
    elseif sym === :alphaMode && x !== nothing
        x === "OPAQUE" || x === "MASK" || x === "BLEND" ||
            throw(ArgumentError("""the material's alpha rendering mode should be one of: "OPAQUE", "MASK", "BLEND" """))
    elseif sym === :alphaCutoff && x !== nothing
        x ≥ 0 || throw(ArgumentError("alphaCutoff should be ≥ 0"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Material}) = JSON3.Mutable()
JSON3.omitempties(::Type{Material}) = (:pbrMetallicRoughness, :normalTexture, :occlusionTexture, :emissiveTexture, :emissiveFactor, :alphaMode, :alphaCutoff, :doubleSided, :name, :extensions, :extras)
