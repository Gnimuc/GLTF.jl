function _item_restriction!(subtypeArgs, vectorArgs, array)
    @assert haskey(array, "items") "Every `array` type in glTF is supposed to have an item restriction aka `items`. Please checkout $val."
    items = array["items"]
    if isa(items, Dict)
        @assert haskey(items, "type") "There is no `type` in the `items`, please checkout your schema: $items."
        itemsType = items["type"]
        if itemsType == "string"
            push!(subtypeArgs, :String)
        elseif itemsType == "number" || itemsType == "integer"
            push!(subtypeArgs, :Number)
        elseif itemsType == "boolean"
            push!(subtypeArgs, :Bool)
        elseif itemsType == "array"
            push!(vectorArgs, Expr(:curly, :Vector))
            _item_restriction!(subtypeArgs, vectorArgs[2], array)
        elseif itemsType == "object"
            # TODO
        elseif itemsType == "null"
            # TODO
        else
            # TODO
        end
    elseif isa(items, Array)
        # TODO
    end
    push!(vectorArgs, subtypeArgs[1])
end
