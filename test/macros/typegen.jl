import GLTF: _item_restriction!
using Base.Test
using JSON

@testset "type generation" begin
    typegenJSON = JSON.parsefile(joinpath(@__DIR__, "typegen.json"))
    @testset "item restriction" begin
        single, _, nested, object, ref = typegenJSON["items restriction"]
        @testset "single" begin
            ex = Expr(:type, false, Expr(:curly, :ItemResSingle), Expr(:block))
            curly, block = ex.args[2], ex.args[3]
            push!(curly.args, Expr(:(<:), :T))
            push!(block.args, Expr(:(::), :x, Expr(:curly, :Vector)))
            _item_restriction!(curly.args[end].args, block.args[end].args[2].args, single)
            @test ex == Expr(:type, false, Expr(:curly, :ItemResSingle, :(T<:Integer)), Expr(:block, :(x::Vector{T})))
        end
        @testset "nested" begin
            ex = Expr(:type, false, Expr(:curly, :ItemResNested), Expr(:block))
            curly, block = ex.args[2], ex.args[3]
            push!(curly.args, Expr(:(<:), :T))
            push!(block.args, Expr(:(::), :x, Expr(:curly, :Vector)))
            _item_restriction!(curly.args[end].args, block.args[end].args[2].args, nested)
            @test ex == Expr(:type, false, Expr(:curly, :ItemResNested, :(T<:Integer)), Expr(:block, :(x::Vector{Vector{T}})))
        end
        @testset "object" begin
            ex = Expr(:type, false, Expr(:curly, :ItemResObj), Expr(:block))
            curly, block = ex.args[2], ex.args[3]
            push!(curly.args, Expr(:(<:), :T))
            push!(block.args, Expr(:(::), :x, Expr(:curly, :Vector)))
            _item_restriction!(curly.args[end].args, block.args[end].args[2].args, object)
            @test ex == Expr(:type, false, Expr(:curly, :ItemResObj, :(T<:Dict{String,Int})), Expr(:block, :(x::Vector{T})))
        end
        @testset "ref" begin
            ex = Expr(:type, false, Expr(:curly, :ItemResRef), Expr(:block))
            curly, block = ex.args[2], ex.args[3]
            push!(curly.args, Expr(:(<:), :T))
            push!(block.args, Expr(:(::), :x, Expr(:curly, :Vector)))
            _item_restriction!(curly.args[end].args, block.args[end].args[2].args, ref)
            @test ex == Expr(:type, false, Expr(:curly, :ItemResRef, :(T<:Asset)), Expr(:block, :(x::Vector{T})))
        end
    end
end
