mutable struct Scene
    nodes::Set{Int}
    name::String
    extensions::Dict
    extras
    function Scene(; nodes=Set(), name="", extensions=Dict(), extras=nothing)
        obj = new()
        if !isempty(nodes)
            all(n ≥ 0 for n in nodes) || throw(ArgumentError("the indices of each root node should be ≥ 0"))
            obj.nodes = nodes
        end
        name == "" || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Scene keywordargs begin
    nodes => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
