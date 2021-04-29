@testset "Test creating new GameState" begin
    gs = Retrosheet.newgamestate()
    @test isa(gs,GameState)
end