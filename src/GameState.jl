
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


"""Look up full name of player in lineup of team currently  at bat.

$(SIGNATURES)
"""
function offensiveplayer(playercode::AbstractString, gs::GameState)
    batters = gs.half == BOTTOM ? gs.homelineup : gs.visitorlineup
    matches = filter(pl -> pl.id == playercode, batters)
    if isempty(matches)
        @warn "No offensive player found for " * playercode
        playercode
    else
        matches[1].player
    end
end

"""Look up full name of player in lineup of team currently in the field.

$(SIGNATURES)
"""
function defensiveplayer(playercode::AbstractString, gs::GameState)
    batters = gs.half == BOTTOM ? gs.visitorlineup : gs.homelineup
    matches = filter(pl.id == playercode, batters)
    matches[1]
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
        "game ready to begin")
end

"""Compose label for current half inning.

$(SIGNATURES)
"""
function inninglabel(gs::GameState)
    gs.half == Retrosheet.TOP ? string("top of the ", ordinallabel(gs.inning)) : string("bottom of the ", ordinallabel(gs.inning))
end

"""Compose label for current number of outs.

$(SIGNATURES)
"""
function outslabel(gs)
    gs.outs == 1 ? "1 out" : string(gs.outs, " outs")
end


"""Compose label for current score.

$(SIGNATURES)
"""
function scorelabel(gs)
    string(gs.scorehome,"-",gs.scorevisitor)
end

"""Compose label for current batter.

$(SIGNATURES)
"""
function atplate(gs)
    offensiveplayer(gs.batter, gs)
end

"""Update state of base runners based on specified event.

$(SIGNATURES)
Returns modified `GameState`.
"""
function updaterunners!(gs::GameState,evt::PlayEvent)
    # CHECK FOR SB, other events
    oldrunners = [gs.runner1, gs.runner2, gs.runner3]
    if evt.play[1] == 'S'
        gs.runner1 = evt.player
    elseif evt.play[1] == 'D'
        gs.runner2 = evt.player
    elseif evt.play[1] == 'T'
        gs.runner3 = evt.player
    end

    parts = split(evt.play, ".")
    if length(parts) == 1
        gs
    else
        playparts = split(parts[2], "/")
        println("HERE ARE PLAY PARTS ",playparts)
    end
    println(parts[1])
    gs
end


"""Update description of most recent play for specified event.

$(SIGNATURES)
Returns modified `GameState`.
"""
function updateplay!(gs, play)
    gs.lastplay = labelplay(play.play)
    gs
end


"""Update state of game to account for `play`.

$(SIGNATURES)
"""
function updatestate!(gamestate::GameState, play::PlayEvent)
    if isnothing(play)
        gamestate
    else

        if gamestate.outs == 3
            @info "Resetting outs and base runners: after 3 outs."
            gamestate.outs = 0
            gamestate.runner1 = nothing
            gamestate.runner2 = nothing
            gamestate.runner3 = nothing
            gamestate.half = gamestate.half == Retrosheet.TOP ? Retrosheet.BOTTOM : Retrosheet.TOP
            @info string(inninglabel(gamestate), outslabel(gamestate))
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

        # update runners
        gamestate = updaterunners!(gamestate, play)

        # Update last play
        gamestate = updateplay!(gamestate, play)
        # check play description
        @info showstate(gamestate)
        gamestate
    end
end


"""Compose labels with full names for baserunners identified by player code.

$(SIGNATURES)
"""
function runnerslabel(gs::GameState)
    labels = []
    runners = [gs.runner1, gs.runner2, gs.runner3]
    bases = ["first", "second", "third"]
    for i in 1:3
        r = runners[i]
        if ! isnothing(r)
            push!(labels, offensiveplayer(r, gs) * " now on " * bases[i]) 
        end
    end
    join(labels, ", ")
end

"""Compose text description of current game state.

$(SIGNATURES)
"""
function showstate(gs::GameState)
    descriptions = [scorelabel(gs),inninglabel(gs),outslabel(gs)]
    push!(descriptions, string(atplate(gs), " at bat"))
    push!(descriptions, gs.lastplay)
    runners = runnerslabel(gs)
    if ! isempty(runners)
        push!(descriptions, runners)
    end
    
    join(descriptions, ", ") * "."
end


"""Collect text description of all plays in a given inning.

$(SIGNATURES)

Note that it's necessary to play through the game up to the requested inning
before collecting the transcription for the requested inning.


# Arguments

- `gs` Game state.
- `eventlist` List of play events for this game.
- `inning` Inning to transcribe
"""
function inningxcript(gs::GameState, eventlist, inning::Int64)
    inningevts = filter(evt -> evt.inning == inning, eventlist)
    descriptions = []
    for evt in inningevts
        gs = updatestate!(gs, evt)
        push!(descriptions, showstate(gs))
    end
    descriptions
end



function printinning(gs, eventlist, inning::Int64)
    # Play previous innings to set state:
    for ing in 1:(inning - 1)
        playit = inningxcript(gs, eventlist, ing)
    end
    xcript = inningxcript(gs, eventlist, inning)
    println("\n\n")
    println("INNING ", inning, "\n")
    println(join(xcript,"\n"))
end