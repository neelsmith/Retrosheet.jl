
@testset "Test composing game ID with date and home team" begin
    gameday = Date(1979,8,1)
    hometeam = "BOS"
    expected = "19790801BOS0"
    @test  Retrosheet.gameid(gameday, hometeam) == expected
end