# User's guide



The `ScheduledGame` is the listing for a game in the official schedule for a season: games may or may not have been played (e.g., due to rainout).

For games that *were* played, Retrosheet.jl can use the game's unique identifier to retrieve the play-by-play record of events and parse those into `PlayEvent` objects.

### Load data

Get a season schedule:

```@example eg
using Retrosheet
sched60sox = season(1960, "BOS")
length(sched60sox)
```
Choose a game, find its ID.
```@example eg
game10 = sched60sox[10]
```
```@example eg
game10id = game10 |> gameid
```
Retrieve raw Retrosheet project data and parse its event descriptions:

```@example eg
allevents = game10id |> gamerecord |> plays
```

