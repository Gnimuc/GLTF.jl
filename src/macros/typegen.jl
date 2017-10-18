function _deref(ref)
    path = joinpath(SCHEMA_DEFAULT_DIR, ref)
    schema = JSON.parsefile(path)
    objName = filter(x->!isspace(x), schema["title"])
    # TODO: support Extension & Extras
    if isupper(objName[1]) && objName != "Extension" && objName != "Extras"
        return Symbol(objName)
    else
        return Symbol()
    end
end

function _item_restriction!(subtypeArgs, vectorArgs, array)
    @assert haskey(array, "items") "Every `array` type in glTF is supposed to have an item restriction aka `items`. Please checkout $val."
    items = array["items"]
    @assert isa(items, Dict) "Per-element item restrictions are not supported."
    if haskey(items, "type")
        elementType = items["type"]
        if haskey(BASIC_TYPE, elementType)
            push!(subtypeArgs, BASIC_TYPE[elementType])
            push!(vectorArgs, subtypeArgs[1])
        elseif elementType == "array"
            push!(vectorArgs, Expr(:curly, :Vector))
            _item_restriction!(subtypeArgs, vectorArgs[2].args, items)
        elseif elementType == "object"
            # only for mesh.primitive.targets
            # Basic Morph Syntax: https://github.com/KhronosGroup/glTF/issues/210#issuecomment-282153391
            push!(subtypeArgs, :(Dict{String,Int}))
            push!(vectorArgs, subtypeArgs[1])
        else
            throw(AssertionError("Invalid glTF array eltype: $elementType."))
        end
    elseif haskey(items, "\$ref")
        push!(subtypeArgs, _deref(items["\$ref"]))
        push!(vectorArgs, subtypeArgs[1])
    else
        throw(AssertionError("There is no `type` or `\$ref` in the `items`, please checkout your schema: $items."))
    end
end

function object_restriction!(subtypeArgs)

end
