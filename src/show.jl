for ty = (:Primitive, :Mesh, :Skin, :Node, :Scene,
          :Indices, :Values, :Sparse, :Accessor,
          :Orthographic, :Perspective, :Camera,
          :Target, :Channel, :AnimationSampler, :Animation,
          :Object, :Asset, :Buffer, :BufferView, :Image, :Texture, :Sampler,
          :TextureInfo, :NormalTextureInfo, :OcclusionTextureInfo, :PBRMetallicRoughness, :Material)
    @eval begin
        function Base.show(io::IO, ::MIME"text/plain", x::$ty)
            print(io, $ty, ":")
            for name in fieldnames($ty)
                isdefined(x, name) || continue
                v = getfield(x, name)
                v != nothing && print(io, "\n  $name: ", v)
            end
        end
    end
end
