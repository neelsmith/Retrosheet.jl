
@testset "Test composing game ID with date and home team" begin
    gameday = Date(1979,8,1)
    hometeam = "BOS"
    expected = "19790801BOS0"
    @test  Retrosheet.gameid(gameday, hometeam) == expected
end

@testset "Test extracting basic game info from record" begin
    sched60sox = season(1960, "BOS")
    game1record = sched60sox[1] |> gameid |> gamerecord
    basicinfo = gameinfo(game1record)
    @test basicinfo.hometeam == "WS1"
    @test basicinfo.visitor == "BOS"
    @test basicinfo.stadium == "WAS09"
end


@testset "Test extracting lineups from record" begin
    sched60sox = season(1960, "BOS")
    game1record = sched60sox[1] |> gameid |> gamerecord
    players = lineup(game1record)
    @test length(players) == 18
    @test players[1].player == "Pumpsie Green"
end