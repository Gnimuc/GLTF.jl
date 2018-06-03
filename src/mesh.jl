mutable struct Primitive
    attributes::Dict{String,Int}
    indices::Int
    material::Int
    mode::Int
    targets::Vector{Dict}
    extensions::Dict
    extras
    function Primitive(attributes; indices=-1, material=-1, mode=-1, targets=[], extensions=Dict(), extras=nothing)
        obj = new()
        isempty(attributes) && throw(ArgumentError("attributes should not be empty"))
        obj.attributes = attributes
        if indices != -1
            indices ≥ 0 || throw(ArgumentError("the index of the accessor that contains mesh indices should be ≥ 0"))
            obj.indices = indices
        end
        if material != -1
            material ≥ 0 || throw(ArgumentError("the index of the material to apply to this primitive when rendering should be ≥ 0"))
            obj.material = material
        end
        if mode != -1
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
Primitive(; attributes=Dict(), indices=-1, material=-1, mode=-1, targets=[],
    extensions=Dict(), extras=nothing) = Primitive(attributes, indices=indices, material=material, mode=mode, targets=targets, extensions=extensions, extras=extras)
JSON2.@format Primitive keywordargs begin
    indices => (omitempty=true,)
    material => (omitempty=true,)
    mode => (omitempty=true, default=4)
    targets => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end


mutable struct Mesh
    primitives::Vector{Primitive}
    weights::Vector{Cfloat}
    name::String
    extensions::Dict
    extras
    function Mesh(primitives; weights=[], name="", extensions=Dict(), extras=nothing)
        obj = new()
        isempty(primitives) && throw(ArgumentError("primitives should not be empty"))
        obj.primitives = primitives
        isempty(weights) || (obj.weights = weights;)
        name == "" || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
Mesh(; primitives=[], weights=[], name="", extensions=Dict(), extras=nothing) = Mesh(primitives, weights=weights, name=name, extensions=extensions, extras=extras)
JSON2.@format Mesh keywordargs begin
    weights => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
