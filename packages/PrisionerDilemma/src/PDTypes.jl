
"""
    PlayResult

Stores information of a match. `me` stores my play, `other` stores the play of the adversary. Finally payoff stores the result of the match.
"""
struct PlayResult
	me::Bool
	other::Bool
	payoff::Int64
end

function Base.show(io::IO, res::PlayResult)
	println(io, "I  played: ", res.me ? "Cooperate" : "Not Cooperate")
	println(io, "He played: ", res.other ? "Cooperate" : "Not Cooperate")
	println(io, "My reward: ", res.payoff)

	return nothing
end

struct Player{F}
	name::String
	strategy::String
	matches::Vector{Tuple{String, PlayResult}}
	action::F
end

function Base.show(io::IO, pl::Player)
	println(io, "## Player ", pl.name)
	println(io, " # Strategy")
	println(io, pl.strategy)
	println(io, " # END strategy")
	
	println(io, " # Results after ", length(pl.matches), " matches")
	s = 0
	for i in 1:length(pl.matches)
		if i <= 20
			print(io, "     (", pl.matches[i][1], ", ", pl.matches[i][2].me, ", ",
			pl.matches[i][2].other, ", ", pl.matches[i][2].payoff, ")")
			if i%3 == 0
				println(io, "")
			end
		end
		s = s + pl.matches[i][2].payoff
	end
	if length(pl.matches) > 20
		println(io, "...")
	end
	println(io, "\n # TOTAL number of points: ", s)

	return nothing
end

"""
    function total_payoff(pl::Player)

Given a player, returns the total payoff.
"""
function total_payoff(pl::Player)

    s = 0
    for i in 1:length(pl.matches)
        s = s + pl.matches[i][2].payoff
    end

    return s
end
