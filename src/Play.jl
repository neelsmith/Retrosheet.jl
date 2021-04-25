struct Play
    inning::Int64
    team::Int64 # home or visitor
    player::AbstractString
    balls_strikes
    pitches
    play
end


"""Construct `Play` from delimited-text string.
"""
function play(delimited::AbstractString)
    fields = split(delimited, ",")
    inning = parse(Int64, fields[2])
    team = parse(Int64, fields[3])
    player = fields[4]
    bscount = ""
    fields[5] == "??" ? bscount = nothing : bscount = fields[5]
    pitches = ""
    isempty(fields[6]) ? pitches = nothing : pitches = fields[6]
    event =  fields[7]
    Play(inning, team, player,
    bscount, pitches,
    event)    
end