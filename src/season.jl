
"""Read a schedule for all teams for a given season from the appropriate file in the Chadwick repository.

$(SIGNATURES)

# Arguments

- `yr` is an integer value for a year
- `chadwick` is a local clone of the Chadwick data repository
"""
function season(yr::Int64, chadwick::Chadwick)
    fname = string(chadwick.root,  "/schedule/", yr, "SKED.TXT")
    data = readlines(fname)
    nonempty = filter(row -> length(row) > 20, data)
    map(row -> scheduledgame(row), nonempty)
end

"""Read the schedule for a given team in a given season from the appropriate file in the Chadwick repository.

$(SIGNATURES)


# Arguments

- `yr` is an integer value for a year
- `teamcode` is a three-character code for a team
- `chadwick` is a local clone of the Chadwick data repository
"""
function season(yr::Int64, teamcode::AbstractString, chadwick::Chadwick)
    fname = string(chadwick.root,  "/schedule/", yr, "SKED.TXT")
    data = readlines(fname)
    nonempty = filter(row -> length(row) > 20, data)
    allgames =map(row -> scheduledgame(row), nonempty)
    filter(game -> game.visitingteamcode == teamcode || game.hometeamcode == teamcode, allgames)
end



"""Read a schedule for all teams for a given season from the appropriate file in the Chadwick repository.

$(SIGNATURES)

# Arguments

- `yr` is an integer value for a year
"""
function season(yr::Int64)
    url =  string(CHADWICK_RAW,  "schedule/", yr, "SKED.TXT")
    r = HTTP.request("GET", url)
    data = split(String(r.body), "\r\n")

    nonempty = filter(row -> length(row) > 20, data)
    map(row -> scheduledgame(row), nonempty)
end




"""Read the schedule for a given team in a given season from the appropriate file in the Chadwick repository.

$(SIGNATURES)


# Arguments

- `yr` is an integer value for a year
- `teamcode` is a three-character code for a team
"""
function season(yr::Int64, teamcode::AbstractString)
    url = string(CHADWICK_RAW,  "/schedule/", yr, "SKED.TXT")
    r = HTTP.request("GET", url)
    data = split(String(r.body), "\r\n")
    nonempty = filter(row -> length(row) > 20, data)
    allgames =map(row -> scheduledgame(row), nonempty)
    filter(game -> game.visitingteamcode == teamcode || game.hometeamcode == teamcode, allgames)
end