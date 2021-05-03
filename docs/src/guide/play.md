# Replaying a historical game

Collect a play-by-play record for a game.

```@example play
using Retrosheet
sched = season(1979, "BOS")
openingday = sched[1] |> gameid |> gamerecord
```

Create an initial gamestate

```@example play
gs = openingday |> gamestate
```

Here's the intial state of the game

```@example play
gs |> Retrosheet.showstate
```


Collect the play-by-play events

```@example play
evts = openingday |> plays
```

Update the game state play by play

```@example play
gs = updatestate(gs, evts[1])
gs |> Retrosheet.showstate
```