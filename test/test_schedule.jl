

@testset "Test parsing one scheduled game from delimited text" begin
    csv = """"19790408","0","Sun","TEX","AL",3,"DET","AL",3,"D","Cold","19790808"
"""
    game = Retrosheet.scheduledgame(csv)
    @test game.visitingteamcode == "TEX"
    @test game.hometeam == "DET"
    @test Dates.monthname(game.gamedate) == "April"
    @test Dates.dayname(game.gamedate) == "Sunday"
end