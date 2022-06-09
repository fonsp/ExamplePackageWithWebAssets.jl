### A Pluto.jl notebook ###
# v0.19.8

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ f8876450-e33a-11ec-3f16-f7f889d4e955
begin
	import Pkg
	Pkg.activate(temp=true)
	Pkg.add([
		Pkg.PackageSpec(name="Revise", version="3")
		# if you need additional packages for this example notebook, add them here:
		Pkg.PackageSpec(name="Example")
	])
	Pkg.develop(path=joinpath(@__DIR__, ".."))

	# import revise first
	import Revise
	import Example
	
	import ExamplePackageWithWebAssets
end

# ╔═╡ 6905dbe1-2a6f-4207-bae5-decbb0eebe96
@bind name html"<input>"

# ╔═╡ 8f325844-9b02-4663-828c-3c85dc85acb7
g = ExamplePackageWithWebAssets.Greeting(name)

# ╔═╡ daf4ad0c-e5b3-44af-906f-47736e6df406
repr(MIME"text/html"(), g)

# ╔═╡ 6a67b315-3777-486a-a2f7-926b943e8e82
`deno bundle $(["asdf", "asdf"]) asdf $(()) ff`

# ╔═╡ 8c5a35f4-5a99-427b-858b-38fcf8cba6f1
ExamplePackageWithWebAssets.DEV_MODE[] = false

# ╔═╡ 45b6fa51-7f55-4471-b423-1315c1060e60


# ╔═╡ Cell order:
# ╠═6905dbe1-2a6f-4207-bae5-decbb0eebe96
# ╠═8f325844-9b02-4663-828c-3c85dc85acb7
# ╠═daf4ad0c-e5b3-44af-906f-47736e6df406
# ╠═6a67b315-3777-486a-a2f7-926b943e8e82
# ╠═8c5a35f4-5a99-427b-858b-38fcf8cba6f1
# ╠═f8876450-e33a-11ec-3f16-f7f889d4e955
# ╠═45b6fa51-7f55-4471-b423-1315c1060e60
