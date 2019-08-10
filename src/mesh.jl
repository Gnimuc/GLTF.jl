mutable struct Primitive
    attributes::Dict{String,Int}
    indices::Union{Nothing,Int}
    material::Union{Nothing,Int}
    mode::Union{Nothing,Int}
    targets::Union{Nothing,Vector{Dict}}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Primitive()
        obj = new()
        obj.indices = nothing
        obj.material = nothing
        obj.mode = nothing
        obj.targets = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

function Base.getproperty(obj::Primitive, sym::Symbol)
    x = getfield(obj, sym)
    sym === :mode && x === nothing && return 4
    return x
end

function Base.setproperty!(obj::Primitive, sym::Symbol, x)
    if sym === :indices && x !== nothing
        x ≥ 0 || throw(ArgumentError("the index of the accessor that contains mesh indices should be ≥ 0"))
    elseif sym === :material && x !== nothing
        x ≥ 0 || throw(ArgumentError("the index of the material to apply to this primitive when rendering should be ≥ 0"))
    elseif sym === :mode && x !== nothing
        x === POINTS || x === LINES || x === LINE_LOOP || x === LINE_STRIP ||
            x === TRIANGLES || x === TRIANGLE_STRIP || x === TRIANGLE_FAN ||
                throw(ArgumentError("the type of primitives to render should be one of: POINTS(0), LINES(1), LINE_LOOP(2), LINE_STRIP(3), TRIANGLES(4), TRIANGLE_STRIP(5), TRIANGLE_FAN(6)"))
    end
    setfield!(obj, sym, x)
end

JSON3.StructType(::Type{Primitive}) = JSON3.Mutable()
JSON3.omitempties(::Type{Primitive}) = (:indices, :material, :mode, :targets, :extensions, :extras)


mutable struct Mesh
    primitives::ZVector{Primitive}
    weights::Union{Nothing,Vector{Cfloat}}
    name::Union{Nothing,String}
    extensions::Union{Nothing,Dict}
    extras::Union{Nothing,Dict}
    function Mesh()
        obj = new()
        obj.weights = nothing
        obj.name = nothing
        obj.extensions = nothing
        obj.extras = nothing
        obj
    end
end

JSON3.StructType(::Type{Mesh}) = JSON3.Mutable()
JSON3.omitempties(::Type{Mesh}) = (:weights, :name, :extensions, :extras)
