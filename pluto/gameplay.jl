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
	Pkg.add(url="https://github.com/neelsmith/retrosheet.jl")

	Pkg.add("PlutoUI")
	Pkg.add("Markdown")
	Pkg.add("Dates")
	
	using Retrosheet
	using PlutoUI
	using Markdown
	using Dates
	
	Pkg.status()
end


# ╔═╡ 6b3747b5-9b38-42db-b556-95071c713be5
md"""># Regular-season replay
"""

# ╔═╡ 9c9017d4-47c5-4952-817e-cffe85f0277a
md"""## 1. Choose a game

- Browse the regular-season schedule for a team in any year from 1877-2019.
- Choose a specific date to see a game.

"""

# ╔═╡ 85a6696b-a41f-47b4-99dd-d5aa558f832a
md"""
---
Data to bury at bottom of nb.
"""

# ╔═╡ 8ac6c8e2-ee33-4c4e-bfd3-935063951682
# Currently covered years
yearsincluded =[ "2019",
"2018",
"2017",
"2016",
"2015",
"2014",
"2013",
"2012",
"2011",
"2010",
"2009",
"2008",
"2007",
"2006",
"2005",
"2004",
"2003",
"2002",
"2001",
"2000",
"1999",
"1998",
"1997",
"1996",
"1995",
"1994",
"1993",
"1992",
"1991",
"1990",
"1989",
"1988",
"1987",
"1986",
"1985",
"1984",
"1983",
"1982",
"1981",
"1980",
"1979",
"1978",
"1977",
"1976",
"1975",
"1974",
"1973",
"1972",
"1971",
"1970",
"1969",
"1968",
"1967",
"1966",
"1965",
"1964",
"1963",
"1962",
"1961",
"1960",
"1959",
"1958",
"1957",
"1956",
"1955",
"1954",
"1953",
"1952",
"1951",
"1950",
"1949",
"1948",
"1947",
"1946",
"1945",
"1944",
"1943",
"1942",
"1941",
"1940",
"1939",
"1938",
"1937",
"1936",
"1935",
"1934",
"1933",
"1932",
"1931",
"1930",
"1929",
"1928",
"1927",
"1926",
"1925",
"1924",
"1923",
"1922",
"1921",
"1920",
"1919",
"1918",
"1917",
"1916",
"1915",
"1914",
"1913",
"1912",
"1911",
"1910",
"1909",
"1908",
"1907",
"1906",
"1905",
"1904",
"1903",
"1902",
"1901",
"1900",
"1899",
"1898",
"1897",
"1896",
"1895",
"1894",
"1893",
"1892",
"1891",
"1890",
"1889",
"1888",
"1887",
"1886",
"1885",
"1884",
"1883",
"1882",
"1881",
"1880",
"1879",
"1878",
"1877",
]

# ╔═╡ 6b894af4-4902-48db-8b50-2f28eb3eab3c
md"""Team: $(@bind fanteam Select([
		"ATL" => "Atlanta Braves", 
		"BOS" => "Boston Red Sox", 
		"CLE" => "Cleveland Indians"], 
	default="BOS")) Season: $(@bind fanyear Select(yearsincluded)) 
"""

# ╔═╡ 8466c4fa-9568-4050-a9c2-5b964b5bc316
defaultgame = begin
	Date(parse(Int64,fanyear), 4, 1)
end

# ╔═╡ c72efb28-30b8-4292-b1aa-9f6542afc7e0
begin
	md"Pick a game date: $(@bind gameday DateField(defaultgame))"
end

# ╔═╡ 69bfde19-3c66-4410-9864-d747829b5299
# Users-selected game day as a Date object
#dt = Date(gameday)
gamedate = Date(gameday)

# ╔═╡ a30cb2e4-7da0-4c62-b380-a9ca04fa77a6
begin
	caltable = Retrosheet.htmlcal(gamedate, fanteam)
	heading = "<blockquote>Schedule for <b>$(fanteam) $(monthname(gamedate)), $(year(gamedate))</b> <br/> Key: <span class='home'>Home</span> <span class='away'>Away</span></blockquote>"
	HTML("$heading $caltable")
end

# ╔═╡ 9aedaa02-f753-4e28-ba2f-bf5457328888
# Schedule for user-selected year and team
schedule = begin
	yr = parse(Int64, fanyear)
	season(yr, fanteam)
end


# ╔═╡ 666a429c-86db-4505-92e0-e04ef296c814
playaction = begin 
	 matches = filter(g -> g.gamedate == gamedate, schedule)
	if isempty(matches) 
		[]
	else
		matches[1] |> gameid |> gamerecord |> plays
	end
end

# ╔═╡ a59e92c8-c7ab-4c70-b8b7-b82e8e9adc15
begin
	if isempty(playaction)
		md"No game played on $(gamedate)"
	else
		md"Game on $(gamedate) had $(length(playaction)) plays."
	end
end

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

# ╔═╡ 556672e1-9975-4c5c-ac47-a5528171691c
md"""
---
CSS
"""


# ╔═╡ af970841-1a3f-4465-a3f3-646de981f8c2
html"""<style> 
pluto-output table tr td {
	text-align: center;
}
pluto-output table tr td.home {
    background-color: blue;
	color: white;
	font-weight: bold;
}  

pluto-output table tr td.away {
    background-color: #ff9999;
	font-weight: bold;
	font-style: italic;
}

pluto-output blockquote span.home {
    background-color: blue;
	color: white;
	font-weight: bold;
}

pluto-output blockquote span.away {
    background-color: #ff9999;
	font-weight: bold;
	font-style: italic;
}

</style>
"""

# ╔═╡ Cell order:
# ╟─f8321024-a80b-11eb-1a2e-55f03724ef5c
# ╟─6b3747b5-9b38-42db-b556-95071c713be5
# ╟─9c9017d4-47c5-4952-817e-cffe85f0277a
# ╟─6b894af4-4902-48db-8b50-2f28eb3eab3c
# ╟─a30cb2e4-7da0-4c62-b380-a9ca04fa77a6
# ╟─c72efb28-30b8-4292-b1aa-9f6542afc7e0
# ╟─a59e92c8-c7ab-4c70-b8b7-b82e8e9adc15
# ╟─85a6696b-a41f-47b4-99dd-d5aa558f832a
# ╟─666a429c-86db-4505-92e0-e04ef296c814
# ╟─69bfde19-3c66-4410-9864-d747829b5299
# ╟─8466c4fa-9568-4050-a9c2-5b964b5bc316
# ╟─9aedaa02-f753-4e28-ba2f-bf5457328888
# ╟─8ac6c8e2-ee33-4c4e-bfd3-935063951682
# ╟─67e3a9ec-fbc2-47cb-ad97-7e156b3bf0d3
# ╟─2caf7e0f-587b-45ba-a0ea-d4f7a091d243
# ╟─637c7f52-195e-4026-8845-cc1e3a56f180
# ╟─7d7d7c0a-061f-466e-94f4-46e9143cf3c8
# ╟─5adedc9b-9729-4d7c-87c3-eb47e7c26841
# ╟─7806137e-517d-494d-a11c-86fe958e581c
# ╟─8f442fde-46b0-4a2a-a273-e3648ab6c8ef
# ╠═637d1719-9ace-4ee2-b0e7-1177e942cf3c
# ╟─556672e1-9975-4c5c-ac47-a5528171691c
# ╟─af970841-1a3f-4465-a3f3-646de981f8c2
