

struct LineupPlayer
    id::AbstractString
    player::AbstractString
    homevisitor::Int64
    batting::Int64
    fieldingcode::Int64
    position
end


"""Parse one row of data for a starting player into a `LineupPlayer`.

$(SIGNATURES)
"""
function player(delimited)
    data = split(delimited, ",")
    # skip label in column 1
    LineupPlayer(
        data[2],
        replace(data[3],"\"" => ""),
        parse(Int64, data[4]),
        parse(Int64, data[5]),
        parse(Int64,data[6]),
        positionlabels[data[6]]
    )
end


"""Extract lineups from gamerecord.

$(SIGNATURES)
"""
function lineup(gamerecord)
    players = filter(row -> startswith(row, "start,"), gamerecord)
    map(row -> player(row), players)
end

function homelineup(gamerecord)
    allplayers = lineup(gamerecord)
    filter(pl -> pl.homevisitor == Retrosheet.HOME, allplayers)
end

function visitorlineup(gamerecord)
    allplayers = lineup(gamerecord)
    filter(pl -> pl.homevisitor == Retrosheet.VISITOR, allplayers)
end

function mdplayer(player)
    string(player.batting, ". ", player.player, " *", player.position, "*")
end

function mdlineup(players)
    map(player -> mdplayer(player), players)
end

function htmlplayer(player)
    string("<li>", player.player, " <i>", player.position, "</i></li>")
end

function htmllineup(players)
    playeritems = map(pl -> htmlplayer(pl), players)
    string("<ol>\n", join(playeritems,"\n"), "\n</ol>")
end