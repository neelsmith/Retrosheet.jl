
"""Standard information recorded about a game.

$(SIGNATURES)
"""
struct GameInfo
    hometeam
    visitor
    stadium
end

"""Extract labelled information item from complete game record.

$(SIGNATURES)
# Arguments

- `delimited` is a Vector of retrosheet strings for a game's record.
- `item` is the category of `info` entry to find.
"""
function infoforitem(delimited, item)
    heading = string("info,", item, ",")
    matches = filter(row -> startswith(row, heading), delimited)
    data = replace(matches[1], heading => "")
end


"""Extract basic game information from retrosheet game record.

$(SIGNATURES)
"""
function gameinfo(gamerec)
    GameInfo(
        infoforitem(gamerec, "hometeam"),
        infoforitem(gamerec, "visteam"),
        infoforitem(gamerec, "site")
    )
end