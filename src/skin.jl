mutable struct Skin
    inverseBindMatrices::Union{Nothing,Int}
    skeleton::Union{Nothing,Int}
    joints::Set{Int}
    name::Union{Nothing,String}
    extensions::Dict
    extras
    function Skin(; joints, inverseBindMatrices=nothing, skeleton=nothing, name=nothing, extensions=Dict(), extras=nothing)
        obj = new()
        isempty(joints) && throw(ArgumentError("indices of skeleton nodes should not be empty"))
        obj.joints = joints
        if inverseBindMatrices != nothing
            inverseBindMatrices ≥ 0 || throw(ArgumentError("the index of the accessor containing the inverse-bind matrices should be ≥ 0"))
            obj.inverseBindMatrices = inverseBindMatrices
        end
        if skeleton != nothing
            skeleton ≥ 0 || throw(ArgumentError("the index of the node used as a skeleton root should be ≥ 0"))
            obj.skeleton = skeleton
        end
        name == nothing || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
JSON2.@format Skin keywordargs begin
    inverseBindMatrices => (omitempty=true,)
    skeleton => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
