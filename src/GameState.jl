
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
