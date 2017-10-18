module GLTF

using JSON

function load_all_schema(schemaDir)
    allSchema = []
    for (root, dirs, files) in walkdir(schemaDir)
        for file in files
            if endswith(file, ".json")
                schema = JSON.parsefile(joinpath(root, file))
                objName = filter(x->!isspace(x), schema["title"])
                isupper(objName[1]) && (push!(OBJECT, objName); push!(allSchema, schema))
            end
        end
    end
    allSchema
end

const OBJECT = String[]
const SCHEMA_DEFAULT_DIR = joinpath(@__DIR__, "..", "deps", "schema")

load_all_schema(SCHEMA_DEFAULT_DIR)

const BASIC_TYPE = Dict{String,Symbol}("string"=>:String, "integer"=>:Integer, "number"=>:Number, "boolean"=>:Bool)

include("macros/typegen.jl")







end # module
