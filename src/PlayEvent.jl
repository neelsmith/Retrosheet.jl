"""Record for a single event in a game record.

$(SIGNATURES)
"""
struct PlayEvent
    inning::Int64
    team::Int64 # home or visitor
    player::AbstractString
    balls_strikes
    pitches
    play
end


"""Construct a `Play` from a delimited-text string.

$(SIGNATURES)
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
    PlayEvent(inning, team, player,
    bscount, pitches,
    event)    
end

function playorsub(s::AbstractString)
    if startswith(s, "sub,")
        # Implement later
        nothing
    else
        play(s)
    end
end

function plays(lines::Vector)
    filtered = filter(pl -> startswith(pl, "sub,") || startswith(pl, "play,"), lines)
    map(row -> playorsub(row), filtered)
end