
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
    outs::Int64
    runner1
    runner2
    runner3
    lastplay::AbstractString
end




"""Instantiate a `GameState` from the retrosheet record for a played game.

$(SIGNATURES)
"""
function gamestate(gamerecord)
    GameState(
        homelineup(gamerecord),
        visitorlineup(gamerecord),
        0,0,1,0,nothing, nothing, nothing, 
        "Game ready to begin.")
end

"""Update state of game to account for `play`.

$(SIGNATURES)
"""
function updatestate(gamestate::GameState, play::PlayEvent)
    #Play(8, 0, "philt001", "22", "CBBFX", "S8/L6M.1-2")
    gamestate.inning =  play.inning
    # check batter
    # check outs
    # check scores
    # check runners
    # check play description
    gamestate
end