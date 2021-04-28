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

# ╔═╡ 899dba88-a6c7-11eb-02f4-fb9b5ec213c8
begin
	using Pkg
	Pkg.add("PlutoUI")
	Pkg.add("Dates")
	using PlutoUI
	using Dates
end

# ╔═╡ 43958d9a-50b3-4c43-b097-d629fcdc5cf9
@bind gameday DateField(Date(2020, 8,15))

# ╔═╡ 87aee3ec-47b4-48ed-bf4d-5a669311cc16
Date(gameday)

# ╔═╡ Cell order:
# ╠═899dba88-a6c7-11eb-02f4-fb9b5ec213c8
# ╠═43958d9a-50b3-4c43-b097-d629fcdc5cf9
# ╠═87aee3ec-47b4-48ed-bf4d-5a669311cc16
