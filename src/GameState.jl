
"""Variables maintaining state of a game in play.

$(SIGNATURES)

# Members

- `scorehome` Home team's score
- `scorevisitor` Visting team's score
- `inning` Current inning
- `outs` Number of outs
- `runner1` Player ID of runner on first, or `nothing`
- `runner2` Player ID of runner on second, or `nothing`
- `runner3` Player ID of runner on third, or `nothing`
- `lastplay` Text description of most recent play
"""
mutable struct GameState
    homelineup
    visitorlineup
    scorehome::Int64
    scorevisitor::Int64
    inning::Int64
    half::Int64
    outs::Int64
    batter
    runner1
    runner2
    runner3
    lastplay::AbstractString
end




"""Instantiate a `GameState` from the retrosheet record for a played game.

$(SIGNATURES)
"""
function gamestate(gamerecord)
    allbatters = lineup(gamerecord)
    GameState(
        homelineup(gamerecord),
        visitorlineup(gamerecord),
        0,0,
        1, Retrosheet.TOP,0,
        allbatters[1].id,
        nothing, nothing, nothing, 
        "Game ready to begin.")
end

function inninglabel(gs)
    gs.half == Retrosheet.TOP ? string("top of the ", ordinallabel(gs.inning)) : string("bottom of the ", ordinallabel(gs.inning))
end

function outslabel(gs)
    gs.outs == 1 ? "1 out" : string(gs.outs, " outs")
end

function scorelabel(gs)
    string(gs.scorehome,"-",gs.scorevisitor)
end

"""Update state of game to account for `play`.

$(SIGNATURES)
"""
function updatestate(gamestate::GameState, play::PlayEvent)
    if isnothing(play)
        gamestate
    else

        if gamestate.outs == 3
            gamestate.outs = 0
            gamestate.half = gamestate.half == Retrosheet.TOP ? Retrosheet.BOTTOM : Retrosheet.TOP
            println(inninglabel(gamestate), outslabel(gamestate))
        end
        

        #Play(8, 0, "philt001", "22", "CBBFX", "S8/L6M.1-2")
        gamestate.inning =  play.inning
        # update scores
        if play.team == Retrosheet.HOME
            gamestate.scorehome += scores(play)
        else
            gamestate.scorevisitor += scores(play)
        end
        # update batter
        gamestate.batter = play.player

        # update outs
        gamestate.outs += outs(play)


        # check runners
        # check play description
        @info showstate(gamestate)
        gamestate
    end
end

function showstate(gs)
    description = join(
        [scorelabel(gs),
        inninglabel(gs),
        outslabel(gs)], ", "
    )

end