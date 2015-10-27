using GLTF
using Base.Test

defaultProfile = GLTFProfile()
@test defaultProfile.api == "WebGL"
@test defaultProfile.version == "1.0.3"
@test isnull(defaultProfile.extensions)

metadata = GLTFAsset("1.1.1")
@test metadata.version == "1.1.1"
@test metadata.premultipliedAlpha == false
@test isnull(metadata.copyright)
@test isnull(metadata.generator)
@test isnull(metadata.extensions)

buffer = GLTFBuffer("uri")
@test buffer.uri == "uri"
@test buffer.byteLength == 0
@test buffer._type == "arraybuffer"
@test isnull(buffer.name)
@test isnull(buffer.extensions)

bufferView = GLTFBufferView(buffer, 1)
@test bufferView.buffer === buffer
@test bufferView.byteOffset == 1
@test bufferView.byteLength == 0

accessor = GLTFAccessor(bufferView, 2, 3, 4, "type")
@test accessor.bufferView === bufferView
@test accessor.byteOffset == 2
@test accessor.componentType == 3
@test accessor.count == 4
@test accessor._type == "type"
