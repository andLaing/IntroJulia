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

# ╔═╡ db24490e-7eac-11ea-094e-9d3fc8f22784
md"# Introducing _bound_ variables

With the `@bind` macro, Pluto.jl can synchronize a Julia variable with an HTML object!"

# ╔═╡ bd24d02c-7eac-11ea-14ab-95021678e71e
@bind x html"<input type=range>"

# ╔═╡ cf72c8a2-7ead-11ea-32b7-d31d5b2dacc2
md"This syntax displays the HTML object as the cell's output, and uses its latest value as the definition of `x`. Of course, the variable `x` is _reactive_, and all references to `x` come to life ✨

_Try moving the slider!_ 👆" 

# ╔═╡ cb1fd532-7eac-11ea-307c-ab16b1977819
x

# ╔═╡ 816ea402-7eae-11ea-2134-fb595cca3068
md""

# ╔═╡ ce7bec8c-7eae-11ea-0edb-ad27d2df059d
md"### Combining bonds

The `@bind` macro returns a `Bond` object, which can be used inside Markdown and HTML literals:"

# ╔═╡ fc99521c-7eae-11ea-269b-0d124b8cbe48
begin
	dog_slider = @bind 🐶 html"<input type=range>"
	cat_slider = @bind 🐱 html"<input type=range>"
	
	md"""
	**How many pets do you have?**
	
	Dogs: $(dog_slider)
	
	Cats: $(cat_slider)
	"""
end

# ╔═╡ 1cf27d7c-7eaf-11ea-3ee3-456ed1e930ea
md"""
You have $(🐶) dogs and $(🐱) cats!
"""

# ╔═╡ e3204b38-7eae-11ea-32be-39db6cc9faba
md""

# ╔═╡ 5301eb68-7f14-11ea-3ff6-1f075bf73955
md"### Input types

You can use _any_ DOM element that fires an `input` event. For example:"

# ╔═╡ c7203996-7f14-11ea-00a3-8192ccc54bd6
md"""
`a = ` $(@bind a html"<input type=range >")

`b = ` $(@bind b html"<input type=text >")

`c = ` $(@bind c html"<input type=button value='Click'>")

`d = ` $(@bind d html"<input type=checkbox >")

`e = ` $(@bind e html"<select><option value='one'>First</option><option value='two'>Second</option></select>")

`f = ` $(@bind f html"<input type=color >")

"""

# ╔═╡ d774fafa-7f34-11ea-290d-37805806e14b
md""

# ╔═╡ 8db857f8-7eae-11ea-3e53-058a953f2232
md"""## Can I use it?

The `@bind` macro is **built into Pluto.jl** — it works without having to install a package. 

You can use the (tiny) package [PlutoUI.jl](https://github.com/JuliaPluto/PlutoUI.jl) for some predefined input elements. For example, you use `PlutoUI` to write

```julia
@bind x Slider(5:15)
```

instead of 

```julia
@bind x html"<input type=range min=5 max=15>"
```

Have a look at the [sample notebook about PlutoUI](./sample/PlutoUI.jl.jl)!

_The `@bind` syntax in not limited to `html"..."` objects, but **can be used for any HTML-showable object!**_
"""

# ╔═╡ aa8f6a0e-303a-11eb-02b7-5597c167596d


# ╔═╡ 5c1ececa-303a-11eb-1faf-0f3a6f94ac48
md"""## Separate definition and reference
Interactivity works through reactivity. If you put a bond and a reference to the same variable together, then setting the bond will trigger the _entire cell_ to re-evaluate, including the bond itself.

So **do not** write
```julia
md""\"$(@bind r html"<input type=range>")  $(r^2)""\"
```
Instead, create two cells:
```julia
md""\"$(@bind r html"<input type=range>")""\"
```
```julia
r^2
```
"""

# ╔═╡ 55783466-7eb1-11ea-32d8-a97311229e93


# ╔═╡ dddb9f34-7f37-11ea-0abb-272ef1123d6f
md""

# ╔═╡ 23db0e90-7f35-11ea-1c05-115773b44afa
md""

# ╔═╡ f7555734-7f34-11ea-069a-6bb67e201bdc
md"That's it for now! Let us know what you think using the feedback box below! 👇"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╟─db24490e-7eac-11ea-094e-9d3fc8f22784
# ╠═bd24d02c-7eac-11ea-14ab-95021678e71e
# ╟─cf72c8a2-7ead-11ea-32b7-d31d5b2dacc2
# ╠═cb1fd532-7eac-11ea-307c-ab16b1977819
# ╟─816ea402-7eae-11ea-2134-fb595cca3068
# ╟─ce7bec8c-7eae-11ea-0edb-ad27d2df059d
# ╠═fc99521c-7eae-11ea-269b-0d124b8cbe48
# ╠═1cf27d7c-7eaf-11ea-3ee3-456ed1e930ea
# ╟─e3204b38-7eae-11ea-32be-39db6cc9faba
# ╟─5301eb68-7f14-11ea-3ff6-1f075bf73955
# ╠═c7203996-7f14-11ea-00a3-8192ccc54bd6
# ╟─d774fafa-7f34-11ea-290d-37805806e14b
# ╟─8db857f8-7eae-11ea-3e53-058a953f2232
# ╟─aa8f6a0e-303a-11eb-02b7-5597c167596d
# ╟─5c1ececa-303a-11eb-1faf-0f3a6f94ac48
# ╟─55783466-7eb1-11ea-32d8-a97311229e93
# ╟─dddb9f34-7f37-11ea-0abb-272ef1123d6f
# ╟─23db0e90-7f35-11ea-1c05-115773b44afa
# ╟─f7555734-7f34-11ea-069a-6bb67e201bdc
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
