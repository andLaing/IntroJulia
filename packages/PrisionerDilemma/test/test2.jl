using PrisionerDilemma, Test

coop_player = Player("COOPERATIVE", 
    "This bot always cooperate",
	Vector{Tuple{String,PlayResult}}(), 
    (s, matches) -> true)
	
nocoop_player = Player("NON COOPERATIVE", 
    "This bot never cooperates",
	Vector{Tuple{String,PlayResult}}(), 
    (s, matches) -> false)

match!(coop_player, nocoop_player)

@testset "Basic matching testing" begin
    @test total_payoff(coop_player) < total_payoff(nocoop_player)
end
