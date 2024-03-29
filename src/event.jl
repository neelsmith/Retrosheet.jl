
"""Parse Retrosheet project event string into `PlayEvent`.

$(SIGNATURES)
"""
function parseplay(s::AbstractString)
    parts = split(s, ",")
    inning = parse(Int64,parts[1])
    teamatbat = parse(Int64, parts[2])
    atbat = parts[3]
    evt = parts[6]
    PlayEvent(inning, teamatbat, atbat, nothing, nothing, evt)
end

"""Compose prose description of a `PlayEvent`.
$(SIGNATURES)
"""
function labelplay(play::PlayEvent)
    labelplay(play.eventstring)
end



"""Compose prose description of an event string.
$(SIGNATURES)
"""
function labelplay(play::AbstractString)
    parts = split(play, ".")

    modified = split(parts[1], "/")
    if isempty(modified)
        @warn "Couldn't parse play $play"
        nothing
    else
        labelbasic(modified[1])
    end

end


"""Compose prose description of a hit.
$(SIGNATURES)
"""
function labelhit(s)
     # Hits
    # [SDT]or HR followed by numeric location
    
    hitre = r"^([DSTHR]+)(.*)"  
    matchedup = collect(eachmatch(hitre, s))
    hit = matchedup[1].captures[1]

    string(hitlabels[hit])
end


"""Compose prose description of an out.
$(SIGNATURES)
"""
function labelout(s)
    # Outs:
    # K
    # pure numeric sequence
    # 
    if startswith(s,"K")
        "strikeout"
    else
        string("out, ", s)
    end
end



"""Compose prose description for the basic component of an event string.
$(SIGNATURES)

This ignores modifiers describing base running and scoring.
"""
function labelbasic(s::AbstractString)
    if s == "NP"
        # Normally followed by a `sub`.
        "No play."
    elseif occursin(s[1], "SDTH")
        # hit!
        labelhit(s)
    else 
        # out
        labelout(s)
    end
end


function itsahit(s)
    occursin(s[1], "SDTH")
end


"""Compute number of outs in a play.

$(SIGNATURES)
"""
function outs(plevt::PlayEvent)
    total = 0
    if occursin("TP", plevt.play )
        total = 3
    elseif occursin("DP", plevt.play )
        total += 2
    else
        total += 1
    end
    # MODIFY THIS TO CHECK FOR ERRORS!
    outonbases = replace(plevt.play, r"[^X]" => "")
    total += length(outonbases)
end
