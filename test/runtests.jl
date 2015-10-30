using GLTF
using Base.Test

defaultProfile = GLTFProfile()
@test defaultProfile.api == "WebGL"
@test defaultProfile.version == v"1.0.3"
@test isnull(defaultProfile.extensions)

metadata = GLTFAsset("1.1.1")
@test metadata.version == v"1.1.1"
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

animation = GLTFAnimation()
camera = GLTFCamera("perspective")
@test camera._type == "perspective"

function GLTFtest(file::AbstractString)
    rootDict = JSON.parsefile(file)
    println("load rootDict successfully.")
    GLTF.loadasset(rootDict)
    println("loaddasset() checked.")
    GLTF.loadbuffer("buffer_sphere", rootDict)
    println("loadbuffer() checked.")
    GLTF.loadbuffers(rootDict)
    println("loadbuffers() checked.")
    GLTF.loadbufferview("bufferView_vertex", rootDict)
    println("loadbufferview() checked.")
    GLTF.loadbufferviews(rootDict)
    println("loadbufferviews() checked.")
    GLTF.loadshader("vertexShader0", rootDict)
    println("loadshader() checked.")
    GLTF.loadshaders(rootDict)
    println("loadshaders() checked.")
    GLTF.loadprogram("program0", rootDict)
    println("loadprogram() checked.")
    GLTF.loadprograms(rootDict)
    println("loadprograms() checked.")
    GLTF.loadtechniqueparameter("modelViewMatrix", "technique0", rootDict)
    println("loadtechniqueparameter() checked.")
    GLTF.loadtechniqueparameters("technique0", rootDict)
    println("loadtechniqueparameters() checked.")
    GLTF.loadtechniquestates("technique0", rootDict)
    println("loadtechniquestates() checked.")
    GLTF.loadtechnique("technique0", rootDict)
    println("loadtechnique() checked.")
    GLTF.loadtechniques(rootDict)
    println("loadtechniques() checked.")
    GLTF.loadmaterial("material_czmDefaultMat", rootDict)
    println("loadmaterial() checked.")
    GLTF.loadmaterials(rootDict)
    println("loadmaterials() checked.")
    return true
end

@test GLTFtest("sphere.gltf")
