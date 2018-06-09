mutable struct TextureInfo
    index::Int
    texCoord::Union{Nothing,Int}
    extensions::Dict
    extras
    function TextureInfo(; index, texCoord=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        index ≥ 0 || throw(ArgumentError("the index of the texture should be ≥ 0"))
        obj.index = index
        if texCoord != nothing
            texCoord ≥ 0 || throw(ArgumentError("the set index of texture's TEXCOORD attribute used for texture coordinate mapping should be ≥ 0"))
            obj.texCoord = texCoord
        end
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format TextureInfo keywordargs begin
    texCoord => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct NormalTextureInfo
    index::Int
    texCoord::Union{Nothing,Int}
    scale::Union{Nothing,Cfloat}
    extensions::Dict
    extras
    function NornalTextureInfo(; index, texCoord=nothing, scale=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        index ≥ 0 || throw(ArgumentError("the index of the texture should be ≥ 0"))
        obj.index = index
        if texCoord != nothing
            texCoord ≥ 0 || throw(ArgumentError("the set index of texture's TEXCOORD attribute used for texture coordinate mapping should be ≥ 0"))
            obj.texCoord = texCoord
        end
        scale == nothing || (obj.scale = scale;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format NormalTextureInfo keywordargs begin
    texCoord => (omitempty=true,)
    scale => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct OcclusionTextureInfo
    index::Int
    texCoord::Union{Nothing,Int}
    strength::Union{Nothing,Cfloat}
    extensions::Dict
    extras
    function OcclusionTextureInfo(; index, texCoord=nothing, strength=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        index ≥ 0 || throw(ArgumentError("the index of the texture should be ≥ 0"))
        obj.index = index
        if texCoord != nothing
            texCoord ≥ 0 || throw(ArgumentError("the set index of texture's TEXCOORD attribute used for texture coordinate mapping should be ≥ 0"))
            obj.texCoord = texCoord
        end
        if strength != nothing
            0 ≤ strength ≤ 1 || throw(ArgumentError("strength should be should be ≥ 0 and ≤ 1"))
            obj.strength = strength
        end
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format OcclusionTextureInfo keywordargs begin
    texCoord => (omitempty=true,)
    scale => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct PBRMetallicRoughness
    baseColorFactor::Vector{Cfloat}
    baseColorTexture::Union{Nothing,TextureInfo}
    metallicFactor::Union{Nothing,Cfloat}
    roughnessFactor::Union{Nothing,Cfloat}
    metallicRoughnessTexture::Union{Nothing,TextureInfo}
    extensions::Dict
    extras
    function PBRMetallicRoughness(; baseColorFactor=[], baseColorTexture=nothing, metallicFactor=nothing,
                                    roughnessFactor=nothing, metallicRoughnessTexture=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        if !isempty(baseColorFactor)
            length(baseColorFactor) == 4 || throw(ArgumentError("the material's base color factor should exactly contain 4 values(RGBA)"))
            all(0 .≤ baseColorFactor .≤ 1) || throw(ArgumentError("the material's base color factor value should ≥ 0 and ≤ 1"))
            obj.baseColorFactor = baseColorFactor
        end
        baseColorTexture != nothing && (obj.baseColorTexture = baseColorTexture;)
        if metallicFactor != nothing
            0 ≤ metallicFactor ≤ 1 || throw(ArgumentError("the metalness of the material factor should ≥ 0 and ≤ 1"))
            obj.metallicFactor = metallicFactor
        end
        if roughnessFactor != nothing
            0 ≤ roughnessFactor ≤ 1 || throw(ArgumentError("the roughness of the material factor should ≥ 0 and ≤ 1"))
            obj.roughnessFactor = roughnessFactor
        end
        metallicRoughnessTexture != nothing && (obj.metallicRoughnessTexture = metallicRoughnessTexture;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format PBRMetallicRoughness keywordargs begin
    baseColorFactor => (omitempty=true,)
    baseColorTexture => (omitempty=true,)
    metallicFactor => (omitempty=true,)
    roughnessFactor => (omitempty=true,)
    metallicRoughnessTexture => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct Material
    pbrMetallicRoughness::Union{Nothing,PBRMetallicRoughness}
    normalTexture::Union{Nothing,NormalTextureInfo}
    occlusionTexture::Union{Nothing,OcclusionTextureInfo}
    emissiveTexture::Union{Nothing,TextureInfo}
    emissiveFactor::Vector{Cfloat}
    alphaMode::String
    alphaCutoff::Cfloat
    doubleSided::Union{Nothing,Bool}
    name::String
    extensions::Dict
    extras
    function Material(; pbrMetallicRoughness=nothing, normalTexture=nothing, occlusionTexture=nothing, emissiveTexture=nothing,
        emissiveFactor=[], alphaMode="", alphaCutoff=Cfloat(NaN), doubleSided=nothing, name="", extensions=Dict(), extras=nothing)
        obj = new()
        pbrMetallicRoughness != nothing && (obj.pbrMetallicRoughness = pbrMetallicRoughness;)
        normalTexture == nothing && (obj.normalTexture = normalTexture;)
        occlusionTexture == nothing && (obj.occlusionTexture = occlusionTexture;)
        emissiveTexture == nothing && (obj.emissiveTexture = emissiveTexture;)
        if !isempty(emissiveFactor)
            length(emissiveFactor) == 3 || throw(ArgumentError("the RGB components of the emissive color of the material should exactly contain 3 values"))
            all(0 .≤ emissiveFactor .≤ 1) || throw(ArgumentError("the emissive color should be ≥ 0 and ≤ 1"))
            obj.emissiveFactor = emissiveFactor
        end
        if alphaMode != ""
            alphaMode == "OPAQUE" ||
            alphaMode == "MASK" ||
            alphaMode == "BLEND" || throw(ArgumentError("""the material's alpha rendering mode should be one of: "OPAQUE", "MASK", "BLEND" """))
            obj.alphaMode = alphaMode
        end
        if !isnan(alphaCutoff)
            alphaCutoff ≥ 0 || throw(ArgumentError("alphaCutoff should be ≥ 0"))
            obj.alphaCutoff = alphaCutoff
        end
        doubleSided == nothing || (obj.doubleSided = doubleSided;)
        name == "" || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Material keywordargs begin
    pbrMetallicRoughness => (omitempty=true,)
    normalTexture => (omitempty=true,)
    occlusionTexture => (omitempty=true,)
    emissiveTexture => (omitempty=true,)
    emissiveFactor => (omitempty=true,)
    alphaMode => (omitempty=true,)
    alphaCutoff => (omitempty=true,)
    doubleSided => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
