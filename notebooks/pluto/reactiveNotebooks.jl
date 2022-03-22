### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ eefea028-86da-425f-9339-3960ac6e9c6b
import Pkg

# ╔═╡ 847a880f-d8ea-44c8-af9e-dd716a806381
begin
using Markdown
using InteractiveUtils
using PlutoUI
end

# ╔═╡ 0c448718-8c3d-462b-8a6c-8e28d17849c5
using Printf

# ╔═╡ e8fae5a2-3386-445c-8be4-bd3b9f151977
PlutoUI.TableOfContents(title="Pluto: Julia implementation of reactive notebooks", indent=true)

# ╔═╡ cb51eff7-0bdd-4b71-b4e1-59904320c469
Pkg.status()

# ╔═╡ b129ba7c-953a-11ea-3379-17adae34924c
md"""# _Reactive Notebooks_

Pluto implements the concept of **reactive notebook** for the _Julia_ programming language. 

A reactive notebook is a notebook that is always kept up-to-date. So whenever its code is changed or a cell is deleted or moved, the notebook's outputs are automatically updated as if the notebook was executed fresh, from top to bottom.

Consider for example what happens if you run a Jupyter notebook with the following code (the code is in the notebook _hiddenState1.ipynb_ in this directory)

```
	> cell 1: x = 1

	> cell 2: println('x =', x)

  	> cell 3: x = x+3
```

The first time you excecute cell 2, the results is `1`. Now you execute cell 3. If you execute cell 2 again, the result is `4`. Otherwise, cell 2 is stating a lie, since it still affirms that `x=1`, but `x` is now 4. So, the cost to pay for having independent cells in a conventional notebooks (like Jupyter) is *hidden state*. Unless we re-run continuously the notebook, we don't know the state of the variables.

The situation can get worse. Suppose that you rerun cell 2, getting now that `x = 4`. Then, you delete cell 3 from the notebook. Now, cell 2 is claiming that `x = 4` right after cell 1 has defined `x` as being one. 

While this may not seem a big deal for a simple example, hidden state may result in a serious problem in a notebook containing hundreds of lines of code. 

Read more [in this article] (https://www.nature.com/articles/d41586-021-01174-w) or in [this very fun tube by joel grus](https://www.youtube.com/watch?v=7jiPeIFXb6U)

In a reactive notebook hidden state does not exist. This means that the notebook updates itself each time a changed is introduced to keep the state updated. Let's see an example. Type the following code in the cells below:

```
	> x = 1
  
```

The result is x =1. BTW, if you try *println* the output will not go to the notebook but to the terminal. This is a somewhat weird quirck of Pluto (nobody's perfect).

Also, if you try to write the above two sentences in the same cells Pluto will complain. The convention in Pluto requires that you write either one sentence per cell of enclose multiple sentences in begin... end blocks. 

Now, suppose you want to change the state of x, writing a new cell below the two above (try it):


	> x = 2
 
 Yes, you get an error *Multiple definitions for x*. Pluto has binded the variable x to the value 1 and will not let you change its value. In other words, variable are **inmutable** in Pluto. This solves the most obvious case of hidden state. 
 
 Consider now a more subtle case: define the function:
 

 ```
  	
   f(x) = x +2
  
```

Type in a cell:

```
	>y= f(2)
```

Pluto automatically tells us that y=4, as expected. You would get the same behaviour in Jupyter.

The difference is that in Jupyter you could next *delete* the cell with the definition of the function and the value of y would still be 4 (which is senseless, since now the instruction **y = f(2)** refers to an undefined function). Instead, if you delete the cell with the definition of the function in Pluto you will get an error. *UndefVarError: f not defined*

The short story. You can't have hidden state in Pluto notebooks. Every time that you change something in the notebook it will update itself to keep the state clean. 


"""

# ╔═╡ d2713ff7-41a9-4c67-ba28-99f29687fab1
x = 2

# ╔═╡ b267cd55-009e-4da2-832b-1e98dfdd2759
md"""# _Interpolation_

Another useful feature of Pluto is the hability to implement *interpolation* in the markdown text. This allows to present the data in the markdown in terms of what has been computed in the code. For example:

X = $x

Interpolates the value of variable "x" defined in the cell below to the md text. 
"""

# ╔═╡ a7068203-02ac-40a1-ac35-c78f4ab20cb6
squareme(x) = x^2

# ╔═╡ 3bc3a5fc-2ed7-4894-b9ad-6e3e8b50f382
y = "Hello"

# ╔═╡ 952d4797-dd4c-46a0-b54a-d72de23dca17
z="World"

# ╔═╡ 1aeffd56-06e8-4c69-84ee-d70894a79861
chainstring(x,y) = string(x," ", y)

# ╔═╡ d593ca03-3504-4f3f-bd96-15d949f8824c
md"""# _Order does not matter_

In Jupyter notebooks, code is assumed to be executed sequentially (but there is no way to ensure that this is always the case, and this is the source of hidden state much of the time). In Pluto, the absence of hidden state allows one to place code in any order. For example:

Variable x, defined above this cell, has value $x

Variable y, defined below this cell, has value $y

Function **squareme** defined before this cell, takes the value of $x and squares it resulting in $(squareme(x))

Function **chainstring** defined below this cell, allows me to greet you,
$(chainstring(y,z))

"""

# ╔═╡ 3150bf1a-9555-11ea-306f-0fd4d9229a51
md""" # Binding variables

Pluto lets you `@bind` variables to HTML elements. As always, every time you change something, Pluto knows what to update!"""

# ╔═╡ f2c79746-9554-11ea-39ca-298fd09248ad
@bind rangevar html"<input type='range'>"

# ╔═╡ 041cbbb1-9ce1-4997-9ffa-3545beb238b8
rangevar

# ╔═╡ 9cbb36e1-61bd-4439-9f18-58e466f2cc79
md" The power level is $rangevar"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
InteractiveUtils = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[compat]
PlutoUI = "~0.7.37"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "85b5da0fa43588c75bb1ff986493443f821c70b7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "bf0a1121af131d9974241ba53f601211e9303a9e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.37"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═847a880f-d8ea-44c8-af9e-dd716a806381
# ╠═0c448718-8c3d-462b-8a6c-8e28d17849c5
# ╠═e8fae5a2-3386-445c-8be4-bd3b9f151977
# ╠═eefea028-86da-425f-9339-3960ac6e9c6b
# ╠═cb51eff7-0bdd-4b71-b4e1-59904320c469
# ╠═b129ba7c-953a-11ea-3379-17adae34924c
# ╠═b267cd55-009e-4da2-832b-1e98dfdd2759
# ╠═d2713ff7-41a9-4c67-ba28-99f29687fab1
# ╠═a7068203-02ac-40a1-ac35-c78f4ab20cb6
# ╠═d593ca03-3504-4f3f-bd96-15d949f8824c
# ╠═3bc3a5fc-2ed7-4894-b9ad-6e3e8b50f382
# ╠═952d4797-dd4c-46a0-b54a-d72de23dca17
# ╠═1aeffd56-06e8-4c69-84ee-d70894a79861
# ╠═3150bf1a-9555-11ea-306f-0fd4d9229a51
# ╠═f2c79746-9554-11ea-39ca-298fd09248ad
# ╠═041cbbb1-9ce1-4997-9ffa-3545beb238b8
# ╠═9cbb36e1-61bd-4439-9f18-58e466f2cc79
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
