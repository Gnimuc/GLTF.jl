mutable struct Skin
    inverseBindMatrices::Int
    skeleton::Int
    joints::Set{Int}
    name::String
    extensions::Dict
    extras
    function Skin(joints; inverseBindMatrices=-1, skeleton=-1, name="", extensions=Dict(), extras=nothing)
        obj = new()
        isempty(joints) && throw(ArgumentError("indices of skeleton nodes should not be empty"))
        obj.joints = joints
        if inverseBindMatrices != -1
            inverseBindMatrices ≥ 0 || throw(ArgumentError("the index of the accessor containing the inverse-bind matrices should be ≥ 0"))
            obj.inverseBindMatrices = inverseBindMatrices
        end
        if skeleton != -1
            skeleton ≥ 0 || throw(ArgumentError("the index of the node used as a skeleton root should be ≥ 0"))
            obj.skeleton = skeleton
        end
        name == "" || (obj.name = name;)
        isempty(extensions) || (obj.extensions = extensions;)
        extras == nothing || (obj.extras = extras;)
        obj
    end
end
Skin(; joints=Set(), inverseBindMatrices=-1, skeleton=-1, name="", extensions=Dict(),
    extras=nothing) = Skin(joints, inverseBindMatrices=inverseBindMatrices, skeleton=skeleton, name=name, extensions=extensions, extras=extras)
JSON2.@format Skin keywordargs begin
    inverseBindMatrices => (omitempty=true,)
    skeleton => (omitempty=true,)
    name => (omitempty=true,)
    extensions => (omitempty=true,)
    extras => (omitempty=true,)
end
