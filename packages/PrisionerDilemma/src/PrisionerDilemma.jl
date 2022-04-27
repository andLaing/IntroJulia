module PrisionerDilemma

using Random, Plots

import Base.show

include("PDTypes.jl")
export PlayResult, Player, total_payoff

include("PDMatches.jl")
export play, match!, tournament!

end # module
