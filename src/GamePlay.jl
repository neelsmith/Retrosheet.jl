
"""Play-by-play record of game.

$(SIGNATURES)

# Members

- `info` Vector of info 
"""
struct GamePlay
    gameid
    info
    lineup
    events
end

"""Compose game ID string for specified parameters.

$(SIGNATURES)

# Arguments

- `gamedate` Date game was played.
- `teamcode` Three-letter code for home team.
- `gamenum` One of `SINGLE_GAME`, or (for doubleheader) `FIRST_GAME` or `SECOND_GAME`.
"""
function gameid(gamedate::Date, teamcode::AbstractString; gamenum::Int64 = SINGLE_GAME )
    string(Dates.format(gamedate, "yyyymmdd"), teamcode, gamenum)
end