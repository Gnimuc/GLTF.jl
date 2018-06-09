mutable struct Primitive
    attributes::Dict{String,Int}
    indices::Union{Nothing,Int}
    material::Union{Nothing,Int}
    mode::Union{Nothing,Int}
    targets::Vector{Dict}
    extensions::Dict
    extras
    function Primitive(; attributes, indices=nothing, material=nothing, mode=nothing,
                         targets=[], extensions=Dict(), extras=nothing)
        obj = new()
        isempty(attributes) && throw(ArgumentError("attributes should not be empty"))
        obj.attributes = attributes
        if indices != nothing
            indices ≥ 0 || throw(ArgumentError("the index of the accessor that contains mesh indices should be ≥ 0"))
            obj.indices = indices
        end
        if material != nothing
            material ≥ 0 || throw(ArgumentError("the index of the material to apply to this primitive when rendering should be ≥ 0"))
            obj.material = material
        end
        if mode != nothing
            mode == POINTS || mode == LINES || mode == LINE_LOOP || mode == LINE_STRIP || mode == TRIANGLES ||
            mode == TRIANGLE_STRIP || mode == TRIANGLE_FAN || throw(ArgumentError("the type of primitives to render should be one of: POINTS(0), LINES(1), LINE_LOOP(2), LINE_STRIP(3), TRIANGLES(4), TRIANGLE_STRIP(5), TRIANGLE_FAN(6)"))
            obj.mode = mode
        end
        isempty(targets) || (obj.targets = targets;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Primitive keywordargs begin
    indices => (omitempty=true,)
    material => (omitempty=true,)
    mode => (omitempty=true,)
    targets => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct Mesh
    primitives::Vector{Primitive}
    weights::Vector{Cfloat}
    name::Union{Nothing,String}
    extensions::Dict
    extras
    function Mesh(; primitives, weights=[], name=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        isempty(primitives) && throw(ArgumentError("primitives should not be empty"))
        obj.primitives = primitives
        isempty(weights) || (obj.weights = weights;)
        name == nothing || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Mesh keywordargs begin
    weights => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
