
"""A single scheduled game.  It might or might not have been played.
"""
struct ScheduledGame
    gamedate::Date
    gamenum::Int64
    visitingteamcode
    visitorsleaguecode
    visitorsgamenum
    hometeamcode
    homeleaguecode
    homegamenum
    gametimecode
    postponedcancelled
    makeup
end


"""Parse delimited text into a `ScheduledGame`.

$(SIGNATURES)
"""
function scheduledgame(delimited::AbstractString)
    cols = split(delimited, ",")
    gamedate = Date(replace(cols[1], "\"" => ""), "yyyymmdd")
    gamenum = parse(Int64, replace(cols[2], "\"" => ""))
    # Skip day of week: Julia knows that from the Date object
    visitingteam = replace(cols[4], "\"" => "")
    visitorsleague = replace(cols[5], "\"" => "")
    visitorsgamenum = parse(Int64,replace(cols[6], "\"" => ""))

    hometeam = replace(cols[7], "\"" => "")
    homeleague = replace(cols[8], "\"" => "")
    homegamenum = parse(Int64,replace(cols[9], "\"" => ""))

    gametime = replace(cols[10], "\"" => "")
    laterplay = replace(cols[11], "\"" => "")
    makeup = nothing
    try
        makeup = Date(replace(cols[12], "\"" => ""), "yyyymmdd")
    catch
        # Leave makeup as nothing
    end
    ScheduledGame(gamedate, gamenum,
    visitingteam, visitorsleague, visitorsgamenum,
    hometeam, homeleague, homegamenum,
    gametime, 
    laterplay, makeup
    )

end

# MODEL:
# BOS197904050
"""Given a `ScheduledGame, compose game ID usable in looking up record of played game.

$(SIGNATURES)
"""
function gameid(sg::ScheduledGame)
    string(sg.hometeamcode, Dates.format(sg.gamedate,"yyyymmdd"), sg.gamenum)
end