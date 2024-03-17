using GLTF
using Test
using Downloads
using Pkg

const TEST_ASSETS_URL = "https://github.com/KhronosGroup/glTF-Asset-Generator/releases/download/v0.6.1/GeneratedAssets-0.6.1.zip"
const TEST_LOCAL_PATH = joinpath(@__DIR__, "download.zip")
const ASSETS_LOCAL_PATH = joinpath(@__DIR__, "assets")

if !isfile(TEST_LOCAL_PATH)
    @info "downloading test assets..."
    Downloads.download(TEST_ASSETS_URL, TEST_LOCAL_PATH)
end

p7z = VERSION >= v"1.3.0" ? Pkg.PlatformEngines.find7z() : joinpath(Sys.BINDIR, "7z.exe")
isdir(ASSETS_LOCAL_PATH) || run(`$p7z x $TEST_LOCAL_PATH -o$ASSETS_LOCAL_PATH`)

extra_assets = ["DamagedHelmet.gltf"]
for asset in extra_assets
    cp(joinpath(pkgdir(GLTF), "assets", asset), joinpath(ASSETS_LOCAL_PATH, asset); force = true)
end

@testset "glTF-Asset-Generator" begin
    for (root, dirs, files) in walkdir(ASSETS_LOCAL_PATH)
        for file in files
            if endswith(file, ".gltf")
                path = joinpath(root, file)
                @info "loading $path..."
                @test_nowarn load(path)
            end
        end
    end
end;
