using PrisionerDilemma, Test

@testset "Basic tournament check" begin

    players = Vector{Player}()
    push!(players, Player("COOPERATIVE", 
        "This bot always cooperate",
	    Vector{Tuple{String,PlayResult}}(), 
        (s, matches) -> true))
    
    push!(players, Player("NON COOPERATIVE", 
        "This bot never cooperates",
	    Vector{Tuple{String,PlayResult}}(), 
        (s, matches) -> false))

    function fnever(s::String, matches::Vector{Tuple{String, PlayResult}})
        for i in 1:length(matches)
            if s == matches[i][1]
                if !matches[i][2].other
                    return false
                end
            end
        end
    
        return true
    end
        
    never_forget = Player("MERCILESS", 
        "This bot cooperates, unles it is against someone that has not cooperated with him", 
        Vector{Tuple{String,PlayResult}}(), 
        (s, m) -> fnever(s, m))
    push!(players, never_forget)

    function ftft(s::String, matches::Vector{Tuple{String, PlayResult}})

        for i in length(matches):-1:1
            if s == matches[i][1]
                return matches[i][2].other
            end
        end

        return true
    end

    tikfortak = Player("TIKFORTAK",
        "This boot cooperates with a unknown player. If the player is known, acts as the player acted on their last encounter",
        Vector{Tuple{String,PlayResult}}(), 
        (s, m) -> ftft(s, m))
    push!(players, tikfortak)
    
    nrounds = 10000
    tournament!(players, nrounds)

    for i in 1:length(players)
        println(players[i])
        @test total_payoff(players[i]) < 5*nrounds
    end
end