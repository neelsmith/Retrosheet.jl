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
gs = updatestate!(gs, evts[1])
gs |> Retrosheet.showstate
```

A simple application of this updating functionality is illustrated by the `inningxcript` function.  It plays through the game until the beginning of a requested inning, then records play-by-play descriptions of the game's state for that inning.

```@example play
transcript = Retrosheet.inningxcript(gs, evts, 3)
string("THIRD INNING TRANSCRIPT:\n\n", join(transcript, "\n"))
```