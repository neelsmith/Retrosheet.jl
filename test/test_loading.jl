

@testset "Test loading schedule over internet" begin
    sched89sox = season(1989, "BOS")
    @test length(sched89sox) == 162
    sched60sox = season(1960, "BOS")
    @test length(sched60sox) == 154
end