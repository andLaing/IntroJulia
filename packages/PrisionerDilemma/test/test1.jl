using PrisionerDilemma, Test

@testset "Basic checks on PayOff matrix" begin
    r1, r2 = play(true,true)
    @test r1.payoff == r2.payoff
    
    r1, r2 = play(true, false)
    @test r2.payoff > r1.payoff

    r1, r2 = play(false, true)
    @test r1.payoff > r2.payoff
    
    r1, r2 = play(false, false)
    @test r1.payoff == r2.payoff
end 
