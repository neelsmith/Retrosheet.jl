
"""Variables maintaing state of a game in play.

$(SIGNATURES)
"""
mutable struct GameState
    scorehome::Int64
    scorevisitor::Int64
    inning::Int64
    outs::Int64
    runner1
    runner2
    runner3
    lastplay::AbstractString
end


"""Initiate a `GameState`.

$(SIGNATURES)
"""
function newgamestate()
    GameState(0,0,1,0,nothing, nothing, nothing, "Game ready to begin.")
end

"""Update state of game to account for `play`.

$(SIGNATURES)
"""
function updatestate(gamestate::GameState, play::PlayEvent)
    #Play(8, 0, "philt001", "22", "CBBFX", "S8/L6M.1-2")
    gamestate.inning =  play.inning
end