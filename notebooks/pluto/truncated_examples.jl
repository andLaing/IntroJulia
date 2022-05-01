### A Pluto.jl notebook ###
# v0.17.5

using Markdown
using InteractiveUtils

# ╔═╡ d0a42d25-5da0-46d9-8eaf-02e3bdfc8dc5
begin
	import Pkg
	Pkg.activate("../../packages/TruncatedPoly")
	using TruncatedPoly
	
end

# ╔═╡ 54fa5408-c86b-11ec-0a02-8d5c86cc7868
using PlutoUI, Plots, Random

# ╔═╡ 49a38c64-5cbb-4f19-b682-d177c306ada2
md"# More about truncated polynomials

In what sense are truncated polynomials useful? Well, the usefullness must come from where this is a mathematically sound concept. The fact that we discard higher powers $$x^n\, (n>N)$$ with respect to a normal polynomial multiplication is only mathematically sound if we can interpret the variable $$x$$ as small.

If we have a function $$f(a + x)$$, and $$x$$ is small, we can use its Taylor approximation
```math
f(a+x) = f(a) + f'(a)x + \frac{f''(a)}{2} x^2 + ...
```
This automatically imply **that if we exaluate $$f(x)$$ with the series $$x = (a,1,0,0,...)$$** we will get its Taylor expansion!!. Let's make a few examples!
"

# ╔═╡ 1826138c-b049-4439-b237-04874ba93fb2
let 
	f(x) = (1+2*x+4*x^2-4*x^5)/(2+x^2+x^4)
	s = Series((2.0,1.0,0.0,0.0,0.0,0.0,0.0)) # Taylor series around x=2.0
	ftaylor = f(s)

	xv = collect(-1.0:0.05:5.0)
	fv = f.(xv)
	sv = ftaylor.(xv.-2.0)
	plot(xv,fv,label="Function",seriestype=:scatter, ylims=(-20,2))
	plot!(xv,sv,label="Taylor O(6)", lw=3)
end

# ╔═╡ 0c7e7124-6a46-4ae5-a135-d269aaec5c55
md"Note that we have a method to compute derivatives **exactly** (i.e. to machine precision):"

# ╔═╡ eff98c5d-6c48-413c-a287-7ee0ece23fb0
let
	f(x) = sin(x^2+0.5)*(x^2+3)/(exp(x + log(x^2)) + 2*x + 1)
	s = Series((2.0, 1.0, 0.0,0.0,0.0,0.0,0.0,0.0))
	fs = f(s)
	with_terminal() do
		println("Value of the function at x=2.0: ", fs.c[1])
		for i in 2:length(s.c)
			println("  - Derivative of order ", i, " is:", fs.c[i]*factorial(i-1))
		end
	end
	
end

# ╔═╡ 0422eee0-70dc-4fee-9118-729dec3b95e5
md"Let's check this one again"

# ╔═╡ 7d25e9bb-cb13-4b1f-b30f-118a08a78e4c
let 
	f(x) = sin(x^2+0.5)*(x^2+3)/(exp(x + log(x^2)) + 2*x + 1)
	s = Series((2.0,1.0,0.0,0.0,0.0,0.0,0.0)) # Taylor series around x=2.0
	ftaylor = f(s)

	xv = collect(1.0:0.05:3)
	fv = f.(xv)
	sv = ftaylor.(xv.-2.0)
	plot(xv,fv,label="Function",seriestype=:scatter)
	plot!(xv,sv,label="Taylor O(6)", lw=3)
end

# ╔═╡ 2f0d03ec-9bf0-47c6-85ae-db91367cb78c
md"## Differential programming

"

# ╔═╡ Cell order:
# ╠═54fa5408-c86b-11ec-0a02-8d5c86cc7868
# ╠═d0a42d25-5da0-46d9-8eaf-02e3bdfc8dc5
# ╠═49a38c64-5cbb-4f19-b682-d177c306ada2
# ╠═1826138c-b049-4439-b237-04874ba93fb2
# ╟─0c7e7124-6a46-4ae5-a135-d269aaec5c55
# ╠═eff98c5d-6c48-413c-a287-7ee0ece23fb0
# ╠═0422eee0-70dc-4fee-9118-729dec3b95e5
# ╠═7d25e9bb-cb13-4b1f-b30f-118a08a78e4c
# ╠═2f0d03ec-9bf0-47c6-85ae-db91367cb78c
