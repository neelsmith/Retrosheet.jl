module Retrosheet

using Documenter, DocStringExtensions
using Dates
using HTTP

export ScheduledGame
export season, gameid

export GameInfo, LineupPlayer
export gamerecord, gameinfo, homelineup, visitorlineup, plays
export labelplay

export PlayEvent
export scores

export GameState
export gamestate, updatestate


include("PlayEvent.jl")
include("event.jl")
include("Chadwick.jl")
include("GameInfo.jl")
include("GamePlay.jl")
include("GameState.jl")
include("ScheduledGame.jl")
include("LineupPlayer.jl")
include("calendar.jl")



include("season.jl")
include("gamerecord.jl")
include("leagues.jl")

include("constants.jl")

end # module
