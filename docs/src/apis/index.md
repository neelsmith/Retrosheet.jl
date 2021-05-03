# API documentation


## Basic structures
```@docs
ScheduledGame
GameInfo
LineupPlayer
PlayEvent
GameState
```


## Loading data

Retrosheet.jl can load data from the chadwickbureau github repository at [https://github.com/chadwickbureau/retrosheet](https://github.com/chadwickbureau/retrosheet).


Exported functions:

```@docs
season
gameid
gamerecord
gameinfo
homelineup
visitorlineup
plays
```




## Replaying games

Exported functions:

```@docs
gamestate
updatestate!
```

Internal functions:

```@docs
Retrosheet.updaterunners!
Retrosheet.offensiveplayer
Retrosheet.defensiveplayer
Retrosheet.inninglabel
Retrosheet.outslabel
Retrosheet.scorelabel
Retrosheet.atplate
Retrosheet.showstate
Retrosheet.inningxcript
```