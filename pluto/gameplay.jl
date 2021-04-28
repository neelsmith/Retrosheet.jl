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
	Pkg.add("Dates")
	using PlutoUI
	using Markdown
	using Dates
end

# ╔═╡ 6b3747b5-9b38-42db-b556-95071c713be5
md"""># Regular-season replay
"""

# ╔═╡ 9c9017d4-47c5-4952-817e-cffe85f0277a
md"""## 1. Choose a game

Choose a team and date.

"""

# ╔═╡ 6b894af4-4902-48db-8b50-2f28eb3eab3c
md"""Team: $(@bind fanteam Select([
		"ATL" => "Atlanta Braves", 
		"BOS" => "Boston Red Sox", 
		"CLE" => "Cleveland Indians"], 
	default="BOS")) Date: $(@bind gameday DateField(Date(2020, 8,15)))
"""

# ╔═╡ b96b4d04-b4da-46a6-a51c-ef95b4effb30
md"$(fanteam)  $(Date(gameday))"

# ╔═╡ 67e3a9ec-fbc2-47cb-ad97-7e156b3bf0d3
md"""## 2. Replay the game

- Click the *Advance* button to step through the Retrosheet record of a regular-season MLB game play by play.
- Check *backward* and click *Rewind* if you want to step backward from the current point in the game.

*backward* $(@bind backward CheckBox())

---

"""

# ╔═╡ 2caf7e0f-587b-45ba-a0ea-d4f7a091d243
if backward
	md"""#### *Rewind* 1 play $(@bind update Button("Rewind"))"""
else
	md"""#### *Advance* 1 play $(@bind update Button("Advance"))"""
end

# ╔═╡ 7d7d7c0a-061f-466e-94f4-46e9143cf3c8
md"""
---

Game data. In reality would be loaded over internet.
"""

# ╔═╡ 5adedc9b-9729-4d7c-87c3-eb47e7c26841
playevents = [
	"out",
	"single",
	"strikeout",
	"walk",
	"stolen base",
	"pop fly",
	"double",
	"single scoring runner from second",
	"walk",
	"np: substition",
	"strikeout",
	"463 double play"
	]

# ╔═╡ 7806137e-517d-494d-a11c-86fe958e581c
md"""
---

Game counter.  You can ignore this.

"""

# ╔═╡ 637d1719-9ace-4ee2-b0e7-1177e942cf3c
eventindex = []

# ╔═╡ 8f442fde-46b0-4a2a-a273-e3648ab6c8ef
counter = begin

	update
	if backward		
		if isempty(eventindex)
		else
			pop!(eventindex)
		end
	else
		if length(eventindex) < length(playevents)
			push!(eventindex, length(eventindex) + 1)
		end
	end
end

# ╔═╡ 637c7f52-195e-4026-8845-cc1e3a56f180
begin
	if isnothing(counter)
		md"Game has not begun."

	else
		lastidx = counter[end]


		if lastidx > length(playevents)
			md"Game over."
		else

		md"""
		Current play:  $(playevents[lastidx])
		"""
		end
	end
end

# ╔═╡ Cell order:
# ╟─f8321024-a80b-11eb-1a2e-55f03724ef5c
# ╟─6b3747b5-9b38-42db-b556-95071c713be5
# ╟─9c9017d4-47c5-4952-817e-cffe85f0277a
# ╟─6b894af4-4902-48db-8b50-2f28eb3eab3c
# ╟─b96b4d04-b4da-46a6-a51c-ef95b4effb30
# ╟─67e3a9ec-fbc2-47cb-ad97-7e156b3bf0d3
# ╟─2caf7e0f-587b-45ba-a0ea-d4f7a091d243
# ╟─637c7f52-195e-4026-8845-cc1e3a56f180
# ╟─7d7d7c0a-061f-466e-94f4-46e9143cf3c8
# ╟─5adedc9b-9729-4d7c-87c3-eb47e7c26841
# ╟─7806137e-517d-494d-a11c-86fe958e581c
# ╠═8f442fde-46b0-4a2a-a273-e3648ab6c8ef
# ╠═637d1719-9ace-4ee2-b0e7-1177e942cf3c
