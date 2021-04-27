
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

function labelhit(s)
    hitre = r"^([DSTHR]+)(.*)"  
    matchedup = collect(eachmatch(hitre, s))
    hit = matchedup[1].captures[1]

    string(hitlabels[hit])
end

function labelout(s)
    string("OUT! ", s)
end

function labelbasic(s::AbstractString)
    if s == "NP"
        "No play."
    elseif occursin(s[1], "SDTH")
        # hit!
        labelhit(s)
    else 
        # out
        labelout(s)
    # Outs:
    # K
    # pure numeric sequence
    # 
    # Hits
    # [SDT]or HR followed by numeric location
        
    end
end

# Temporary for debugging
function playfromraw(s)

    parts = split(s,",")
    msg = "Look at " * parts[7]
    @info msg
    labelplay(parts[7])
end