

@testset "Test loading season schedule for 1 team over internet" begin
    sched89sox = season(1989, "BOS")
    @test length(sched89sox) == 162
    sched60sox = season(1960, "BOS")
    @test length(sched60sox) == 154
end

@testset "Test getting single game data" begin
    sched89sox = season(1989, "BOS")
    game150 = sched89sox[150] |> Retrosheet.gameid
    gamerec = Retrosheet.gamerecord(game150)
end

