
# For now, regular season only.
function gamerecord(gameid::AbstractString)
  

    # Need to know league.
    # But MIL and HOU have changed leagues so can't map directly.
    teamcode = gameid[1:3]
    if teamcode == "MIL" || teamcode == "HOU"
        @warn "Computing league membership for team $teamcode not yet implemented. Sorry."
        nothing

    else
        # Look up file from:
        # year, home team, for file name
        yrstring = gameid[4:7]
        # Model:
        #event/regular/1916DET.EVA
        url = string(CHADWICK_RAW, "event/regular/", 
            yrstring,teamcode, ".EV", leagueabbr[teamcode])

        # then within file
        # gamedate and optional number
        r = HTTP.request("GET", url)
        blocks = split(String(r.body), r"\r\nid,")
        blocklines = map(b -> split(b,"\r\n"), blocks)
        matches = filter(v -> v[1] == gameid, blocklines)
        if isempty(matches)
            @warn "No games found for id $gameid"
            nothing
        else
            matches[1]
        end
    end
end