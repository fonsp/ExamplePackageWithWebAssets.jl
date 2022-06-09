module ExamplePackageWithWebAssets
using RelocatableFolders
using HypertextLiteral
import Deno_jll: deno

include("./utils.jl")
include_dependency("../Project.toml")


const frontend_dir = @path joinpath(@__DIR__, "../frontend")
const frontend_import_map_path() = let
    p = joinpath(frontend_dir,  "vendor", "import_map.json")
    isfile(p) ? p : nothing
end

function generate_index_js_bundled(; kwargs...)
    bundle_ES6(
        joinpath(frontend_dir, "index.js");
        import_map_path = frontend_import_map_path(),
        kwargs...
    )
end
generate_index_css() = read(joinpath(frontend_dir, "index.css"), String)

const _index_js_bundled = generate_index_js_bundled()
const _index_css = generate_index_css()

const DEV_MODE = Ref{Bool}(false)
index_js_bundled() = DEV_MODE[] ? generate_index_js_bundled() : _index_js_bundled
index_css() = DEV_MODE[] ? generate_index_css() : _index_css


struct Greeting
    name::String
end


function Base.show(io::IO, m::MIME"text/html", widget::Greeting)
    js = index_js_bundled()
    css = index_css()
    
    show(io, m, @htl(
        """
        <span class="MyPackage">
            <div class="Greeting"></div>
            
            <script>
            const { write_greeting } = $(import_local_js(js))
            
            const wrapper = currentScript.parentElement
            const div = wrapper.querySelector(".Greeting")
            
            // Call our JS code, and pass in extra data:
            write_greeting(div, $(widget.name))
            
            </script>
            
            $(import_local_css(css))
        </span>
        """
    ))
end




end