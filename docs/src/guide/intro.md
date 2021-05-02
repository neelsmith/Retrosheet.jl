# User's guide


## Scheduled and played games



1. Retrosheet has planned schedules for all regular season games since 1877. The `ScheduledGame` is the listing in the official schedule for a season: games may or may not have been played (e.g., due to rainout).
2. Retroshoot has play-by-play records for games that were actually planned. The data in these records can be read into three structures: basic information about the teams and location are represented by `GameInfo`; home and visiting lineups are Vectors of `LineupPlayer`s; and plays in the game are captured in a Vector of  `PlayEvent`s.


## Loading data

### Scheduled games

Get a season schedule for a single team in a given year:

```@example eg
using Retrosheet
sched60sox = season(1960, "BOS")
length(sched60sox)
```


### Records of played games

You can retrieve records for a played game using a predictably structured unique ID.  The `gameid` function can compose an ID from a scheduled game record.

```@example eg
game10id =  sched60sox[10] |> gameid
```

Pass the game id to the `gamerecord` function to retrieve the record of a played game:

```@example eg
game10record = game10id |> gamerecord 
```

Extract basic game info:


```@example eg
game10info = game10record |> gameinfo
```
Lineups:

```@example eg
hometeam = game10record |> homelineup
```
```@example eg
visitingteam = game10record |> visitorlineup
```


Play-by-play record of events:

```@example eg
gameevents = game10record |> plays
```