@testset "Test reading scores from PlayEvent" begin
    plevt =  PlayEvent(1, 1, "robib104", nothing, nothing, "D7.3-H;1-H;B-3(E7)")
    @test scores(plevt) == 2
    pl2 = PlayEvent(1, 0, "buddd101", nothing, nothing, "S9")
    @test scores(pl2) == 0

end