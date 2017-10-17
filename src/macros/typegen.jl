function _item_restriction!(subtypeArgs, vectorArgs, array)
    @assert haskey(array, "items") "Every `array` type in glTF is supposed to have an item restriction aka `items`. Please checkout $val."
    items = array["items"]
    @assert isa(items, Dict) "Per-element item restrictions are not supported."
    @assert haskey(items, "type") "There is no `type` in the `items`, please checkout your schema: $items."
    elementType = items["type"]
    if elementType == "string"
        push!(subtypeArgs, :String)
        push!(vectorArgs, subtypeArgs[1])
    elseif elementType == "integer"
        push!(subtypeArgs, :Integer)
        push!(vectorArgs, subtypeArgs[1])
    elseif elementType == "number"
        push!(subtypeArgs, :Number)
        push!(vectorArgs, subtypeArgs[1])
    elseif elementType == "boolean"
        push!(subtypeArgs, :Bool)
        push!(vectorArgs, subtypeArgs[1])
    elseif elementType == "array"
        push!(vectorArgs, Expr(:curly, :Vector))
        _item_restriction!(subtypeArgs, vectorArgs[2].args, items)
    elseif elementType == "object"
        # TODO
    elseif elementType == "null"
        # TODO
    else
        # TODO
    end
end
