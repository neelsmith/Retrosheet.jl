@testset "Test creating new GameState from game record" begin
    sched60sox = season(1960, "BOS")
    game1record = sched60sox[1] |> gameid |> gamerecord
    gs = gamestate(game1record)
    
    @test gs.inning == 1
    @test gs.outs == 0

    @test gs.scorehome == 0
    @test gs.scorevisitor == 0
    
    @test isnothing(gs.runner1)
    @test isnothing(gs.runner2)
    @test isnothing(gs.runner3)

    @test length(gs.homelineup) == 9
    @test length(gs.visitorlineup) == 9
    
    @test gs.lastplay == "game ready to begin."
end