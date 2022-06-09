import Deno_jll
using Test

import ExamplePackageWithWebAssets
import ExamplePackageWithWebAssets: Greeting


@testset "Bundle success" begin
    @testset "Offline JS support" begin
        @test try
            ExamplePackageWithWebAssets.generate_index_js_bundled(; no_remote=true)
            true
        catch e
            @error "The JavaScript source code cannot be bundled without internet access. In VS Code, press Cmd+Shift+P > Run Task > `deno vendor` to fix this." exception=(e,catch_backtrace())
            false
        end
    end


    @test_nowarn repr(MIME"text/html"(), Greeting("hello"))
end