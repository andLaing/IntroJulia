
"""
    play(p1::Bool, p2::Bool)

Given two players strategies cooperate/non-cooperate (true/false), this routine returns the match result as two structures of type PlayResult.
"""
function play(p1::Bool, p2::Bool)
    if p1 && p2
	return PlayResult(true, true, 3), PlayResult(true,true,3)
    end
    
    if p1 && (!p2)
	return PlayResult(true, false, 0), PlayResult(false, true, 5)
    end
    
    if (!p1) && p2
	return PlayResult(false, true, 5), PlayResult(true, false, 0)
    end
    
    if (!p1) && (!p2)
	return PlayResult(false, false, 1), PlayResult(false, false, 1)
    end
end

"""
    match!(pl1::Player, pl2::Player)

Perform a match between player 1 and player 2 by calling Player.action to decide their respective plays.
"""
function match!(pl1::Player, pl2::Player)
    p1 = pl1.action(pl2.name, pl1.matches)
    p2 = pl2.action(pl1.name, pl2.matches)
    
    r1, r2 = play(p1,p2)
    push!(pl1.matches, (pl2.name, r1))
    push!(pl2.matches, (pl1.name, r2))
    
    return nothing
end

"""
    tournament!(pls::Vector{Player}, nrounds)

Given a vector of players `pls`, this routines performs a tournament of `nrounds`. In each round players are paired randomly to match.
"""
function tournament!(pls::Vector{Player}, nrounds)

    npls = length(pls)
    pairing = collect(1:npls)
    for k in 1:nrounds
	Random.shuffle!(pairing)
	for i in 1:div(npls, 2)
	    match!(pls[pairing[2*i-1]], pls[pairing[2*i]])	
	end		
    end
    
    return nothing
end
