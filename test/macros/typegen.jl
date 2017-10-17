import GLTF: _item_restriction!
using Base.Test
using JSON

@testset "type generation" begin
    @testset "item restriction" begin
        @testset "single" begin
            single = JSON.parsefile(joinpath(@__DIR__, "item_restriction_single.json"))
            ex = Expr(:type, false, Expr(:curly, :ItemResSingle), Expr(:block))
            curly = ex.args[2]
            block = ex.args[3]
            push!(curly.args, Expr(:(<:), :T))
            push!(block.args, Expr(:(::), :x, Expr(:curly, :Vector)))
            _item_restriction!(curly.args[end].args, block.args[end].args[2].args, single)
            @test ex == Expr(:type, false, Expr(:curly, :ItemResSingle, :(T<:Integer)), Expr(:block, :(x::Vector{T})))
        end
        @testset "nested" begin
            nested = JSON.parsefile(joinpath(@__DIR__, "item_restriction_nested.json"))
            ex = Expr(:type, false, Expr(:curly, :ItemResNested), Expr(:block))
            curly = ex.args[2]
            block = ex.args[3]
            push!(curly.args, Expr(:(<:), :T))
            push!(block.args, Expr(:(::), :x, Expr(:curly, :Vector)))
            _item_restriction!(curly.args[end].args, block.args[end].args[2].args, nested)
            @test ex == Expr(:type, false, Expr(:curly, :ItemResNested, :(T<:Integer)), Expr(:block, :(x::Vector{Vector{T}})))
        end
    end
end
