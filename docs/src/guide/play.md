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

Collect the play-by-play events

```@example play
evts = opener |> plays
```

Update the game state play by play

```@example play
gs = updatestate(gs, evts[1])
```