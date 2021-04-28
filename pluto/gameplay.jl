### A Pluto.jl notebook ###
# v0.14.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ f8321024-a80b-11eb-1a2e-55f03724ef5c
begin
	using Pkg
	Pkg.add("PlutoUI")
	Pkg.add("Markdown")
	using PlutoUI
	using Markdown
end

# ╔═╡ 96bb6967-ca2f-43ca-b902-31452930a7af
@bind update Button("Change inning")

# ╔═╡ 6fd5a62f-2d08-4adc-83a7-079ae9602570
md"""$(@bind hscore Button("Home scores"))  $(@bind vscore Button("Visitor scores"))
"""

# ╔═╡ 43ae47d0-e514-45d5-9c6d-1e4f43107d60
@bind subbatter Button("Substitute")

# ╔═╡ 7806137e-517d-494d-a11c-86fe958e581c
md"""
---

Initialize a game
"""

# ╔═╡ 637d1719-9ace-4ee2-b0e7-1177e942cf3c
innings = []

# ╔═╡ 8f442fde-46b0-4a2a-a273-e3648ab6c8ef
playedinnings = begin
	update
	push!(innings, length(innings) + 1)
end

# ╔═╡ 4299cb44-237c-4aaa-b39c-1330cb8c8dc2
homescore = []

# ╔═╡ 0e2bfb94-cd11-44f1-9a53-1b3e9958b411
hometeamscore = begin
	hscore
	push!(homescore, 1)
end


# ╔═╡ 9784fbbb-afa9-4810-81af-554bd5f768be
visitorscore = []

# ╔═╡ 0e6a0b18-19bd-4a4d-abb5-40a5c85eea2e
vistingteamscore = begin
	vscore
	push!(visitorscore, 1)
end


# ╔═╡ ad57d86e-0ae0-41d9-b4aa-4b4e788e1bfc
md"""## Inning: $(playedinnings[end])


### Home: **$(sum(hometeamscore))**  Visitor: **$(sum(vistingteamscore))**
"""



# ╔═╡ 7c60b7c0-8a98-41fb-bd1a-53e7845948f1
homelineup = [
	"a",
	"b",
	"c"
	]

# ╔═╡ 4ccd799d-aaa0-4cb6-b594-e6616745ffdb
begin
	items = map(pl -> "1. " * pl, homelineup)
	Markdown.parse("Home lineup:\n\n" * join(items, "\n"))
end

# ╔═╡ 0fd3bab3-6f26-4b5e-8c20-cbd4c7167494
begin
	subbatter
	push!(homelineup, "SUB")
end

# ╔═╡ Cell order:
# ╟─f8321024-a80b-11eb-1a2e-55f03724ef5c
# ╟─96bb6967-ca2f-43ca-b902-31452930a7af
# ╟─6fd5a62f-2d08-4adc-83a7-079ae9602570
# ╟─43ae47d0-e514-45d5-9c6d-1e4f43107d60
# ╠═4ccd799d-aaa0-4cb6-b594-e6616745ffdb
# ╠═0fd3bab3-6f26-4b5e-8c20-cbd4c7167494
# ╟─ad57d86e-0ae0-41d9-b4aa-4b4e788e1bfc
# ╟─7806137e-517d-494d-a11c-86fe958e581c
# ╟─8f442fde-46b0-4a2a-a273-e3648ab6c8ef
# ╟─0e2bfb94-cd11-44f1-9a53-1b3e9958b411
# ╟─0e6a0b18-19bd-4a4d-abb5-40a5c85eea2e
# ╟─637d1719-9ace-4ee2-b0e7-1177e942cf3c
# ╟─4299cb44-237c-4aaa-b39c-1330cb8c8dc2
# ╠═9784fbbb-afa9-4810-81af-554bd5f768be
# ╟─7c60b7c0-8a98-41fb-bd1a-53e7845948f1
