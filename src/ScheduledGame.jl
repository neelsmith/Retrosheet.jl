
struct ScheduledGame
    gamedate
    gamenum
    day
    visitingteam
    visitorsleague
    visitorsgamenum
    hometeam
    homeleague
    homegamenum
    gametime
    postponedcancelled
    makeup
end


"""Parse delimited text into a `ScheduledGame`.

$(SIGNATURES)
"""
function scheduledgame(delimited::AbstractString)
end