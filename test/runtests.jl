using GLTF
using Test
using Downloads
using ZipFile

const TEST_ASSETS_URL = "https://github.com/KhronosGroup/glTF-Asset-Generator/releases/download/v0.6.1/GeneratedAssets-0.6.1.zip"
const TEST_LOCAL_PATH = joinpath(@__DIR__, "download.zip")
const ASSETS_LOCAL_PATH = joinpath(@__DIR__, "assets")

if !isfile(TEST_LOCAL_PATH)
    @info "downloading test assets..."
    Downloads.download(TEST_ASSETS_URL, TEST_LOCAL_PATH)
end

if !isdir(ASSETS_LOCAL_PATH)
    mkpath(ASSETS_LOCAL_PATH)
    archive = ZipFile.Reader(TEST_LOCAL_PATH)
    try
        for entry in archive.files
            parts = split(entry.name, '/')
            any(part -> part == "..", parts) && error("invalid path in test asset archive")
            path = joinpath(ASSETS_LOCAL_PATH, parts...)
            if endswith(entry.name, "/")
                mkpath(path)
            else
                mkpath(dirname(path))
                open(path, "w") do io
                    write(io, read(entry))
                end
            end
        end
    finally
        close(archive)
    end
end

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
