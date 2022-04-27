### A Pluto.jl notebook ###
# v0.17.5

using Markdown
using InteractiveUtils

# ╔═╡ 0afdf42b-e913-4746-bb88-cc6bb1ea75e0
import Random

# ╔═╡ e146b50c-dc5f-4036-8797-b801c3b337b4
md"# Prisionner's dilemma

## Storing results of matches
We need a data type to store the result of a match with an oponent. The options for each player are to cooperate (`true`) or to not cooperate (`false`). The result of the match is given by the payoff matrix:
- If both cooperate, each receive 3 points
- If both choose not to cooperate, each receives 1 point
- If A cooperates and B does not cooperate, A recives 0 points and B receives 5 points
The data type should be able to record the full result of the game: What I payed, what the other played, and the points I got.
"

# ╔═╡ 2a887db2-32a7-4841-baa4-e94c6534c43f
struct PlayResult
	me::Bool
	other::Bool
	payoff::Int64
end

# ╔═╡ 599a7aed-c3cf-4c88-b9f9-28573e06c6a2
md"
It is also convenient to have a way to show the results nicely. Let's use the standard Julia print routines
"

# ╔═╡ a3ffdb46-314b-41df-8eb7-dc95c61f6309
import Base.show

# ╔═╡ 4cfd9a7e-95d2-4122-90d2-a557aff84454
function Base.show(io::IO, res::PlayResult)
	println(io, "I  played: ", res.me ? "Cooperate" : "Not Cooperate")
	println(io, "He played: ", res.other ? "Cooperate" : "Not Cooperate")
	println(io, "My reward: ", res.payoff)

	return nothing
end

# ╔═╡ 4153fc5d-ea6d-4166-9f8b-67fc63c45e7c
md" ## Result of a game
Given two input (each player's choice), we need a routine that gives the match result for each player. It should return *two* `PlayResult` structures, one for each player.
"

# ╔═╡ 352ab987-4e8a-47a6-b099-356e51b5b62b
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


# ╔═╡ 62d19436-8469-415d-9ad9-8fc4b9fa93ff
md" ### Small test 
Two people cooperating:
"

# ╔═╡ cf7da4c2-6f0d-41bc-8b97-cf42c329b3cb
r1, r2 = play(true,true)

# ╔═╡ fdb62f89-859c-42f4-9a5e-6f19699d19e7
md"I cooperate, the other does not"

# ╔═╡ b53ff68a-b79c-4ed4-a17f-ece88d85cc5f
r3, r4 = play(true, false)

# ╔═╡ f9cd91b3-d3f9-40f8-998f-4cc9a86f3e2a
md"I do not cooperate, the other does"

# ╔═╡ 2a3fce48-22ae-442f-ab63-232fbde3aa95
r5, r6 = play(false, true)

# ╔═╡ e9d4e0fd-cf5f-4c24-be99-8da5965484e6
md"We choose not to cooperate (This is Nash equilibrium!)"

# ╔═╡ e5247b82-53c2-49b3-bf53-f77c3d0ab53a
r7, r8 = play(false, false)

# ╔═╡ c387ee39-0007-4550-ac14-710a259097fb
md"## Iterated game
We want different players (with different strategies) to play an iterated version of the Prisionner's dilemma. They will choose to (not) cooperate depending on the past record against. We need a `struct` that keeps:
- The name of the player bot
- A description of the strategy
- A record of past matches. They should store the name of the player and the result of the match
- Finally an implementation of the strategy. This should be a function that uses as input the name against the player we are playing against, and as return value either cooperate/no cooperate (`true`/`false`)
"

# ╔═╡ badb5c4a-e981-4de4-a22d-83bb7537b2ce
struct Player{F}
	name::String
	strategy::String
	matches::Vector{Tuple{String, PlayResult}}
	action::F
end

# ╔═╡ 974e96ea-35eb-45e0-990d-286e1419303e
md"Ir is also conveniet to nicely display a player"

# ╔═╡ 4bdc4f94-8923-4d78-a31a-332b870c5e9d
function Base.show(io::IO, pl::Player)
	println(io, "## Player ", pl.name)
	println(io, " # Strategy")
	println(io, pl.strategy)
	println(io, " # END strategy")
	
	println(io, " # Results after ", length(pl.matches), " matches")
	s = 0
	for i in 1:length(pl.matches)
		if i <= 10
			print(io, "     (", pl.matches[i][1], ", ", pl.matches[i][2].me, ", ",
			pl.matches[i][2].other, ", ", pl.matches[i][2].payoff, ")")
			if i%3 == 0
				println(io, "")
			end
		end
		s = s + pl.matches[i][2].payoff
	end
	if length(pl.matches) > 10
		println(io, "...")
	end
	println(io, "\n # TOTAL number of points: ", s)

	return nothing
end

# ╔═╡ 4b1d6495-648f-43f7-9461-eaf25a7169c2
md"Let's create a player. Simple bot that always cooperate"

# ╔═╡ dcdebed7-33ac-4e39-b00a-9624126a6b3b
pl = Player("COOPERATIVE", "This bot always cooperate", Vector{Tuple{String,PlayResult}}(), (s, matches) -> true)

# ╔═╡ 2ad16948-4682-4539-a378-91067e4c38cb
md"Let's push a couple of random matches as results"

# ╔═╡ 2cf28e96-e527-4658-a302-7ad4dd3b2793
begin
	push!(pl.matches, ("Foo",r3))
	push!(pl.matches, ("Foo", r1))
end

# ╔═╡ 30aeda9e-533b-494f-b578-c9d1ba07b623
pl

# ╔═╡ 6cb74dc9-79c7-41f7-9c60-58c050edfe03
md"### Match between two players
We only need a way to match two players
"

# ╔═╡ 309f4035-7e4a-4d7f-88b4-e241bd536c95
function match!(pl1::Player, pl2::Player)
	p1 = pl1.action(pl2.name, pl1.matches)
	p2 = pl2.action(pl1.name, pl2.matches)

	r1, r2 = play(p1,p2)
	push!(pl1.matches, (pl2.name, r1))
	push!(pl2.matches, (pl1.name, r2))

	return nothing
end

# ╔═╡ ec8e3e92-1508-4739-80c7-48823a289d3b
begin 
	coop_player = Player("COOPERATIVE", "This bot always cooperate",
		Vector{Tuple{String,PlayResult}}(), (s, matches) -> true)
	nocoop_player = Player("NON COOPERATIVE", "This bot never cooperates",
		Vector{Tuple{String,PlayResult}}(), (s, matches) -> false)
	rand_player = Player("RAND", "This bot cooperates randomly (p=0.5)",
		Vector{Tuple{String,PlayResult}}(), (s, matches) -> rand(Bool))

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
	
	never_forget = Player("MERCILESS", "This bot cooperates, unles it is against someone that has not cooperated with him", Vector{Tuple{String,PlayResult}}(), (s, m) -> fnever(s, m))

	nothing
end

# ╔═╡ 7f36cd03-d795-4088-8c2d-efb64663591e
for i in 1:10
	match!(never_forget, rand_player)
end

# ╔═╡ c2b09d00-c128-4b33-a848-492dd3796c78
never_forget

# ╔═╡ c0bd6f05-4311-471e-8fb0-1bb22cc4af8d
coop_player

# ╔═╡ c6013dac-2c98-40c7-a721-d4184aca39c0
rand_player

# ╔═╡ 18a9fea0-2eed-4185-a9a1-cb096484b8c2
md"### Tournaments
A set of players are randomly paired in matches several tims. They play according to their strategy. 
"

# ╔═╡ 7b7558c2-ddf2-4be3-af6b-978f584e5454
function tournament(pls::Vector{Player}, nrounds)

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

# ╔═╡ 66c6d993-ffd4-43b7-b2d4-9395bac40083
md"We also need some fancy way to show the results"

# ╔═╡ 5f99b8d7-7c20-450e-a33b-940eb5efa6b0
begin 
	pls = [deepcopy(rand_player), deepcopy(never_forget), deepcopy(coop_player)]
	tournament(pls, 1000)
end

# ╔═╡ 41e2fcb7-de28-4b2d-a9c3-34e834a35682
pls[1]

# ╔═╡ 57c1049c-dbb3-4b13-ab0e-63004d82c7b8
pls[2]

# ╔═╡ 72c66dd6-450b-4b09-b7c1-b991a3a4de14
pls[3]

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
"""

# ╔═╡ Cell order:
# ╠═0afdf42b-e913-4746-bb88-cc6bb1ea75e0
# ╠═e146b50c-dc5f-4036-8797-b801c3b337b4
# ╠═2a887db2-32a7-4841-baa4-e94c6534c43f
# ╠═599a7aed-c3cf-4c88-b9f9-28573e06c6a2
# ╠═a3ffdb46-314b-41df-8eb7-dc95c61f6309
# ╠═4cfd9a7e-95d2-4122-90d2-a557aff84454
# ╠═4153fc5d-ea6d-4166-9f8b-67fc63c45e7c
# ╠═352ab987-4e8a-47a6-b099-356e51b5b62b
# ╠═62d19436-8469-415d-9ad9-8fc4b9fa93ff
# ╠═cf7da4c2-6f0d-41bc-8b97-cf42c329b3cb
# ╠═fdb62f89-859c-42f4-9a5e-6f19699d19e7
# ╠═b53ff68a-b79c-4ed4-a17f-ece88d85cc5f
# ╠═f9cd91b3-d3f9-40f8-998f-4cc9a86f3e2a
# ╠═2a3fce48-22ae-442f-ab63-232fbde3aa95
# ╠═e9d4e0fd-cf5f-4c24-be99-8da5965484e6
# ╠═e5247b82-53c2-49b3-bf53-f77c3d0ab53a
# ╠═c387ee39-0007-4550-ac14-710a259097fb
# ╠═badb5c4a-e981-4de4-a22d-83bb7537b2ce
# ╠═974e96ea-35eb-45e0-990d-286e1419303e
# ╠═4bdc4f94-8923-4d78-a31a-332b870c5e9d
# ╠═4b1d6495-648f-43f7-9461-eaf25a7169c2
# ╠═dcdebed7-33ac-4e39-b00a-9624126a6b3b
# ╠═2ad16948-4682-4539-a378-91067e4c38cb
# ╠═2cf28e96-e527-4658-a302-7ad4dd3b2793
# ╠═30aeda9e-533b-494f-b578-c9d1ba07b623
# ╠═6cb74dc9-79c7-41f7-9c60-58c050edfe03
# ╠═309f4035-7e4a-4d7f-88b4-e241bd536c95
# ╠═ec8e3e92-1508-4739-80c7-48823a289d3b
# ╠═7f36cd03-d795-4088-8c2d-efb64663591e
# ╠═c2b09d00-c128-4b33-a848-492dd3796c78
# ╠═c0bd6f05-4311-471e-8fb0-1bb22cc4af8d
# ╠═c6013dac-2c98-40c7-a721-d4184aca39c0
# ╠═18a9fea0-2eed-4185-a9a1-cb096484b8c2
# ╠═7b7558c2-ddf2-4be3-af6b-978f584e5454
# ╠═66c6d993-ffd4-43b7-b2d4-9395bac40083
# ╠═5f99b8d7-7c20-450e-a33b-940eb5efa6b0
# ╠═41e2fcb7-de28-4b2d-a9c3-34e834a35682
# ╠═57c1049c-dbb3-4b13-ab0e-63004d82c7b8
# ╠═72c66dd6-450b-4b09-b7c1-b991a3a4de14
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
