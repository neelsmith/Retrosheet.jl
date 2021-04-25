struct Play
    inning::Int64
    team # home or visitor
    player::AbstractString
    balls_strikes
    pitches
    play
end


"""Construct `Play` from delimited-text string.
"""
function play(delimited::AbstractString)
end