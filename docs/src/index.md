# Retrosheet.jl

Maybe this will become a library for working baseball data from [the Retrosheet project](https://www.retrosheet.org).

Here is the license for their data:

> The information used here was obtained free of charge from and is copyrighted by Retrosheet.  Interested parties may contact Retrosheet at 20 Sunset Rd., Newark, DE 19711.


## Quick overview

`ScheduledGames` are the official schedule for a season: games may or may not be played (e.g., due to rainout).

For games that were played, Retrosheet.jl can use the game's unique identifier to retrieve the play-by-play record of events.

### Load data

Get a season schedule:

```@example eg
using Retrosheet
sched60sox = season(1960, "BOS")
length(sched60sox)
```
Choose a game, get its ID.
```@example eg
game10 = sched60sox[10]
```
```@example eg
game10id = game10 |> gameid
```
Retrieve raw Retrosheet project data:
```@example eg
raw = game10id |> gamerecord
```


