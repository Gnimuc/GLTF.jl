using GLTF
using Base.Test


function GLTFtest(file::AbstractString)
    rootDict = JSON.parsefile(file)
    println("load rootDict successfully.")

    # test animation
    GLTF.loadanimationsampler("a_sampler", "an_animation", rootDict)
    println("loadanimationsampler() checked.")

    GLTF.loadanimationchannels("an_animation", rootDict)
    println("loadanimationchannels() checked.")

    GLTF.loadanimation("an_animation", rootDict)
    println("loadanimation() checked.")
    GLTF.loadanimations(rootDict)
    println("loadanimations() checked.")

    # test asset
    GLTF.loadprofile(rootDict)
    println("loadprofile() checked.")

    GLTF.loadasset(rootDict)
    println("loaddasset() checked.")

    # test buffer & bufferView & accessor
    GLTF.loadbuffer("verticesBuffer_id", rootDict)
    println("loadbuffer() checked.")
    GLTF.loadbuffers(rootDict)
    println("loadbuffers() checked.")

    GLTF.loadbufferview("vertices_id", rootDict)
    println("loadbufferview() checked.")
    GLTF.loadbufferviews(rootDict)
    println("loadbufferviews() checked.")

    GLTF.loadaccessor("accessor_id", rootDict)
    println("loadaccessor() checked.")
    GLTF.loadaccessors(rootDict)
    println("loadaccessors() checked")

    # test camera
    GLTF.loadcameraorthograhic("orthographicCamera_id", rootDict)
    println("loadcameraorthograhic() checked")

    GLTF.loadcameraperspective("perspectiveCamera_id", rootDict)
    println("loadcameraperspective() checked")

    GLTF.loadcamera("perspectiveCamera_id", rootDict)
    println("loadcamera() checked.")
    GLTF.loadcameras(rootDict)
    println("loadcameras() checked.")

    # test shader & program & technique
    GLTF.loadshader("vs_id", rootDict)
    println("loadshader() checked.")
    GLTF.loadshaders(rootDict)
    println("loadshaders() checked.")

    GLTF.loadprogram("program_id", rootDict)
    println("loadprogram() checked.")
    GLTF.loadprograms(rootDict)
    println("loadprograms() checked.")

    GLTF.loadtechniqueparameter("ambient", "technique_id", rootDict)
    println("loadtechniqueparameter() checked.")

    GLTF.loadtechniqueparameters("technique_id", rootDict)
    println("loadtechniqueparameters() checked.")

    GLTF.loadtechniquestates("technique_id", rootDict)
    println("loadtechniquestates() checked.")

    GLTF.loadtechnique("technique_id", rootDict)
    println("loadtechnique() checked.")
    GLTF.loadtechniques(rootDict)
    println("loadtechniques() checked.")

    # test material & primitive & mesh & skin & node
    GLTF.loadmaterial("material_id", rootDict)
    println("loadmaterial() checked.")
    GLTF.loadmaterials(rootDict)
    println("loadmaterials() checked.")

    GLTF.loadmeshprimitives("mesh_id", rootDict)
    println("loadmeshprimitives() checked.")

    GLTF.loadmesh("mesh_id", rootDict)
    println("loadmesh() checked.")
    GLTF.loadmeshes(rootDict)
    println("loadmeshes() checked.")

    GLTF.loadskin("skin_id", rootDict)
    println("loadskin() checked.")
    GLTF.loadskins(rootDict)
    println("loadskins() checked.")

    GLTF.loadnode("meshes_node_id", rootDict)
    println("loadnode() checked.")
    GLTF.loadnodes(rootDict)
    println("loadnodes() checked.")

    GLTF.loadscene("defaultScene", rootDict)
    println("loadscene() checked.")
    GLTF.loadscenes(rootDict)
    println("loadscenes() checked.")

    GLTF.loadsampler("sampler_id", rootDict)
    println("loadsampler() checked.")
    GLTF.loadsamplers(rootDict)
    println("loadsamplers() checked.")

    GLTF.loadimage("image_id", rootDict)
    println("loadimage() checked.")
    GLTF.loadimages(rootDict)
    println("loadimages() checked.")

    GLTF.loadtexture("texture_id", rootDict)
    println("loadtexture() checked.")
    GLTF.loadtextures(rootDict)
    println("loadtextures() checked.")
    return true
end

@test GLTFtest("example.gltf")
