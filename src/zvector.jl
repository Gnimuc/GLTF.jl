import Base: IdentityUnitRange, @propagate_inbounds

# from https://github.com/JuliaArrays/CustomUnitRanges.jl/blob/master/src/ZeroRange.jl
"""
    ZeroRange(n)
Defines an `AbstractUnitRange` corresponding to the half-open interval
[0,n), equivalent to `0:n-1` but with the lower bound guaranteed to be
zero by Julia's type system.
"""
struct ZeroRange{T<:Integer} <: AbstractUnitRange{T}
    len::T
    ZeroRange{T}(len) where {T} = new{T}(max(zero(T), len))
end
ZeroRange(len::T) where {T<:Integer} = ZeroRange{T}(len)

Base.length(r::ZeroRange) = r.len

Base.length(r::ZeroRange{T}) where {T<:Union{Int,Int64}} = T(r.len)

let smallint = (Int === Int64 ?
                Union{Int8,UInt8,Int16,UInt16,Int32,UInt32} :
                Union{Int8,UInt8,Int16,UInt16})
    Base.length(r::ZeroRange{T}) where {T<:smallint} = Int(r.len)
end

Base.first(r::ZeroRange{T}) where {T} = zero(T)
Base.last(r::ZeroRange{T})  where {T} = r.len-one(T)

function Base.iterate(r::ZeroRange{T}) where T
    r.len <= 0 && return nothing
    x = oftype(one(T) + one(T), zero(T))
    return (x,x)
end
function Base.iterate(r::ZeroRange{T}, i) where T
    x = i + one(T)
    return (x >= oftype(x, r.len) ? nothing : (x,x))
end

@inline function Base.getindex(v::ZeroRange{T}, i::Integer) where T
    @boundscheck ((i > 0) & (i <= length(v))) || Base.throw_boundserror(v, i)
    convert(T, i-1)
end

@inline function Base.getindex(r::ZeroRange{R}, s::AbstractUnitRange{S}) where {R,S<:Integer}
    @boundscheck checkbounds(r, s)
    R(first(s)-1):R(last(s)-1)
end

Base.intersect(r::ZeroRange, s::ZeroRange) = ZeroRange(min(r.len,s.len))

Base.promote_rule(::Type{ZeroRange{T1}},::Type{ZeroRange{T2}}) where {T1,T2} = ZeroRange{promote_type(T1,T2)}
Base.convert(::Type{ZeroRange{T}}, r::ZeroRange{T}) where {T<:Real} = r
Base.convert(::Type{ZeroRange{T}}, r::ZeroRange) where {T<:Real} = ZeroRange{T}(r.len)
ZeroRange{T}(r::ZeroRange) where {T} = convert(ZeroRange{T}, r)

Base.show(io::IO, r::ZeroRange) = print(io, typeof(r).name, "(", r.len, ")")
Base.show(io::IO, ::MIME"text/plain", r::ZeroRange) = show(io, r)

"""
    ZVector{T} <: AbstractVector{T}
Simple 0-based Vector. For a more generic solution, see OffsetArrays.jl.
"""
struct ZVector{T} <: AbstractVector{T}
    x::Vector{T}
end
ZVector() = ZVector(Vector{Any}(undef, 0))
ZVector(::UndefInitializer, m::Integer) = ZVector(Vector{Any}(undef, Int(m)))

Base.parent(A::ZVector) = A.x
Base.size(A::ZVector) = size(parent(A))
Base.size(A::ZVector, d) = size(parent(A), d)

@inline Base.axes(A::ZVector) = (IdentityUnitRange(ZeroRange(length(parent(A)))),)
@inline Base.axes(A::ZVector, d) = d == 1 ? IdentityUnitRange(ZeroRange(length(parent(A)))) : IdentityUnitRange(0:0)

Base.IndexStyle(::Type{T}) where {T<:ZVector} = IndexLinear()
Base.eachindex(::IndexLinear, A::ZVector) = axes(A, 1)

Base.length(A::ZVector) = prod(size(A))

@inline @propagate_inbounds function Base.getindex(A::ZVector{T}, i::Int) where {T}
    @boundscheck checkbounds(A, i)
    @inbounds ret = parent(A)[i + 1]
    ret
end

@inline @propagate_inbounds function Base.getindex(A::ZVector{T}, I::Vararg{Int,N}) where {T,N}
    @boundscheck checkbounds(parent(A), (I .+ 1)...)
    @inbounds ret = parent(A)[(I .+ 1)...]
    ret
end

@inline @propagate_inbounds function Base.setindex!(A::ZVector{T}, val, i::Int) where {T}
    @boundscheck checkbounds(A, i)
    @inbounds parent(A)[i + 1] = val
    val
end

@inline @propagate_inbounds function Base.setindex!(A::ZVector{T}, val, I::Vararg{Int,N}) where {T,N}
    @boundscheck checkbounds(parent(A), (I .+ 1)...)
    @inbounds parent(A)[(I .+ 1)...] = val
    val
end

indexlength(r::AbstractRange) = length(r)
indexlength(i::Integer) = i

ZeroRangeIUR{T} = IdentityUnitRange{ZeroRange{T}}
Base.similar(A::ZVector) = similar(A, eltype(A), size(A))
Base.similar(A::ZVector, ::Type{T}) where {T} = similar(A, T, size(A))
Base.similar(A::ZVector, dims::Dims{1}) = similar(A, eltype(A), dims)
Base.similar(A::ZVector, ::Type{T}, dims::Dims{1}) where {T} = ZVector{T}(undef, first(dims))
Base.similar(A::AbstractVector, ::Type{T}, inds::Tuple{ZeroRangeIUR,Vararg{ZeroRangeIUR}}) where {T} = ZVector(similar(A, T, map(indexlength, inds)))
Base.similar(::Type{T}, shape::Tuple{ZeroRangeIUR,Vararg{ZeroRangeIUR}}) where {T<:AbstractArray} = ZVector(T(undef, map(indexlength, shape)))
