### A Pluto.jl notebook ###
# v0.18.1

using Markdown
using InteractiveUtils

# ╔═╡ 5e7de9f0-c6ee-11ec-36a8-ed4d13eeb11a
using PlutoUI, Markdown

# ╔═╡ ade8143e-bc62-45ae-a5f8-a40cd5fa8afd
using DataFrames

# ╔═╡ bc9790ab-3aa2-464e-b398-8d76d6d20d91
# We can read ascii data in using the CSV package
using CSV

# ╔═╡ 13ee834a-6af8-453f-b694-69645c88dc8e
PlutoUI.TableOfContents(title="DataFrames: Basic functionality", indent=true)

# ╔═╡ dffa1033-ba0a-4f6f-a923-fdb51c79326b
md"# _The DataFrames package_

DataFrames are tabular structures that allow the user to group data of different types and easily manipulate and add to the information. For those of you familiar with python (*pandas*) or R (*dplyr etc*), the Julia implementation will seem familiar.

This class will introduce some basic functionality of the package before moving into. General information about the DataFrames.jl package can be found [here](https://dataframes.juliadata.org/stable/)"

# ╔═╡ 4acfbea8-c62c-4b4b-b638-39d7d3b78dd9
md"## _1. Basic definitions_

An empty DataFrame"

# ╔═╡ 37bf8354-ec5f-4257-b5d6-5bea6321e485
let
	df_empty = DataFrame()
	md"When we define a DataFrame without arguments we get an object of type $(typeof(df_empty)) DataFrame of size $(size(df_empty)), we can check if it's empty easily with the `isempty` function which in our case gives: $(isempty(df_empty))"
end

# ╔═╡ 731e598f-99fb-43e5-a161-8b5bf49ee233
md"Defining using a a Dictionary"

# ╔═╡ e2572630-d888-46bf-849d-72800088d0a6
begin
	dict1 = Dict("x" => [1, 2, 3, 4], "y" => [11, 12, 13, 14], "z" => [21, 22, 23, 24])
	df_dict = DataFrame(dict1)
end

# ╔═╡ ed2593ed-e341-4ce3-88fa-78ca31da5faa
md"As you'd expect we get a DataFrame with column names as the keys of the dictionary and each row having the appropriate values from the dictionary. If we ask `isempty` we, of course get $(isempty(df_dict)) and we get the dimensions with `size` : $(size(df_dict))"

# ╔═╡ a7b096a1-dbc7-4c98-b7d6-c7d9f6d0b1c3
md"We can also skip the extra Dictionary step and just put the information in a DataFrame:"

# ╔═╡ bf451ad3-bd26-4576-b5ca-b70644368c48
df_direct = DataFrame("x" => [11, 22, 33, 44], "y" => [21, 22, 23, 24], "z" => [31, 32, 33, 34])

# ╔═╡ f17cd6af-7328-496a-aa9c-4d67b97eb785
md"## _2. Accessing columns and rows_"

# ╔═╡ 6ade1750-568f-4c59-a709-d94d4d040c6c
md"### _Direct access_

Get the 1st row and all columns"

# ╔═╡ 874dbcea-fac6-4b56-8023-3005b523d125
df_direct[1, :]

# ╔═╡ 9bc6eae6-7cbf-4bae-9c71-e20dc3a34cf5
md"Direct column access gives a vector of the values in the column"

# ╔═╡ edaa9d5b-d46f-4c93-8e93-26bcef7bbb9d
df_direct.x

# ╔═╡ cad829aa-51c5-4528-9737-192ed3ff51ad
md"Access using a string is also possible and needed if the column name has spaces or hyphens"

# ╔═╡ 1ec739d5-15d5-43ba-b41a-db741c0d675c
df_direct[!, "x"], df_direct."x"

# ╔═╡ 4a14c49f-b965-4c7c-88e8-2f350847ed88
md"Here `!` is a shorthand for 'all rows', `:` is equivalent but gives a copy of the column. If you wanted to access only a few column indices replace `!` with the index or range, give it a try!"

# ╔═╡ 871c71ce-215a-4741-9a86-eb7806a49c85
md"Symbol access is also possible and very efficient. Both `:name` and `Symbol(\"string name\")` are possible."

# ╔═╡ 52e4bbd9-c05a-4431-b74b-32d2a7504a10
df_direct[!, :x], df_direct[!, Symbol("x")]

# ╔═╡ 0d43056a-475f-47e3-ae3a-dc32d8e55507
md"If, at any time, you want to know what columns are defined in the DataFrame you can ask with names(df_name) and you'll get an array of strings. There are also functions to get the number of rows and number of columns, look them up and check.

What if you want one of the columns but still in DataFrame format? Or all but a group of columns? You can use [:name] or Not"

# ╔═╡ 9c552660-de93-45db-bce4-eb022e913ce5
# Get a DataFrame type column
typeof(df_direct[!, [:y]])

# ╔═╡ bc22d6b6-936a-4a6c-a725-e2cc35801ea0
# All but y
df_direct[!, Not(:y)]

# ╔═╡ 9408c7e2-3d8f-4054-8590-e73137dd1319
md"There are lots of other simple access functions like: `Between`, `All`, `Cols`
Have a look to see what they can do.

Remember that putting `?` at the start of a cell here allows you to look up documentation here or in julia interactive"

# ╔═╡ 6c2a0e0e-e572-4bb0-808d-c3fea3dcc985
md"### Iteration

Iterate over the columns with `eachcol`"

# ╔═╡ e20dda28-8998-4f4a-b2ab-e9df49838af2
with_terminal() do
	for col in eachcol(df_direct)
    	println("Column values: ", col)
	end
end

# ╔═╡ 58e611a9-870c-4d7f-b5bb-68009d68cde8
md"And the rows with `eachrow`"

# ╔═╡ 24a2a96e-b15f-4acf-b641-3ca81ca78ddd
with_terminal() do
	for row in eachrow(df_direct)
    	println("Row values: ", row)
	end
end

# ╔═╡ c07e3cc1-9d75-44e7-82bb-e1d1519ebf7d
md"If you want to iterate over groups of data having some common trait you can do so using the `groupby` function"

# ╔═╡ 389407c9-c366-495f-8538-acfef56881d5
df_commonx = DataFrame(:x => [1,1,2,2,2,3,3,4], :y => [22,23,19,25,26,47,49,90], :z => split("df with strings and integers. ready for grouping"))

# ╔═╡ 2a5ec8fc-8dab-4009-ab17-ee374d316df5
with_terminal() do
	for grp in groupby(df_commonx, :x)
		println("Group: ", grp)
	end
end

# ╔═╡ 59e8e6dc-acd2-40f3-86ec-55f0cf6d8e80
md"GroupedDataFrames have some additional functions which allow the user to understand the grouping. Have a look at the documentation"

# ╔═╡ 9ea2b223-621c-4310-9f04-0ca50d90e6b0
groupcols(groupby(df_commonx, :x)), keys(groupby(df_commonx, :x))

# ╔═╡ e50858de-85e5-40f8-9c6a-f69db0b94008
md"### Conditional access and filtering

A condition that produces a boolean array of the correct length can be used to select rows in a matrix"

# ╔═╡ 83477b92-6bae-4aa0-819f-579ee7fca6f0
df_direct[df_direct.x .> 12, :]

# ╔═╡ 74f80681-6a15-4417-a468-9cfda3dc1fe0
md"This functionality is also possible with the `filter` and `filter!` functions which take a functional argument and apply it to each row"

# ╔═╡ 420e409b-e66e-4880-828a-9c77e06491a9
filter(df -> df.x > 12, df_direct)

# ╔═╡ 35c763f0-8248-49cd-a5e4-118e0743ad73
md"Have a look at the `subset` function too. Try and use it to make selections in the DataFrame"

# ╔═╡ 60df44af-03b7-44d2-9415-2d2e0a2913b4
md"## _3. Adding to a DataFrame_"

# ╔═╡ 1453476d-37d7-491e-9c05-505c721e27f8
md"### Simple ways to add more data to your DataFrame

Adding columns"

# ╔═╡ 194a1b6a-c262-44d9-a853-54fae28a13c9
df_manipulate = let
	# Make a copy to avoid Pluto cleverness.
	df_manipulate = copy(df_direct)
	# Add a new column of Floats
	df_manipulate.flt_vals = [99.5, 75.7, 33.987, 80.3]
	df_manipulate
end
	

# ╔═╡ 2e113e34-b067-4707-81d1-23c5e51bc7d2
md"What would happen if the length of the vector you passed what different to the existing number of rows? Try and see."

# ╔═╡ 1c5ae69c-0f73-48c8-aab4-85b4afba1429
df_manipulate2 = let
	# Again we have to copy because Pluto.
	df_manipulate2 = copy(df_manipulate)
	#now we use push!(<DataFrame name>, <iterable of length ncol>)
	push!(df_manipulate2, (55, 25, 35, 99.734))
end

# ╔═╡ 247e6f2b-da54-4bf4-b941-cefa41dcea40
md"## _4. Some more clever manipulations_

First let's get some data which is provided with the package so we have more to work with:"

# ╔═╡ 3b050df1-c3df-4984-9cdd-63e79c8e0833
df_iris = let
	df_dir    = dirname(pathof(DataFrames))
	iris_file = joinpath(df_dir, "..", "docs", "src", "assets", "iris.csv")
	CSV.read(iris_file, DataFrame)
end

# ╔═╡ 87eff33f-e295-43e3-937a-a1b1c66b134c
md"Have a look at the data to see what's available. Hint: the `describe` function could be interesting."

# ╔═╡ 3365aead-c359-4f03-ad35-fe012978dfee
md"Now we're going to introduce some useful functions for manipulating DataFrames:
`select`, `transform` and `combine`"

# ╔═╡ b71d6466-2a8b-48cd-9bfe-cbc99c8c97f8
select(df_iris, :Species, :SepalWidth)

# ╔═╡ 249aee53-29e6-4217-bb96-a12ef2246c1b
md"`select` can be used to select columns and also to perform operations on them and always returns a DataFrame with the same number of rows. Inplace version available with `select!` too.

We can use a function to operate on the columns."

# ╔═╡ 4f0107b6-e710-4f43-a53b-5813ae1ef2d6
select(df_iris, :PetalWidth => sum, :PetalLength => (x -> x * 2) => :twicePetalLength, [:SepalLength, :SepalWidth] => ByRow(*))

# ╔═╡ 1a7e4fcb-7814-4954-b72a-e6e669265568
md"`transform` works the same as `select` but always returns the existing columns"

# ╔═╡ b39a9103-8a99-44e7-a0aa-54d0a70dbd5c
transform(df_iris, :PetalWidth => sum, :PetalLength => (x -> x * 2) => :twicePetalLength, [:SepalLength, :SepalWidth] => ByRow(*))

# ╔═╡ f44c32a6-e23c-4206-bf48-c1c1c463adef


# ╔═╡ 24d23ae9-444d-45da-a776-eca4e1a6bf98
md"combine can return a DataFame of any shape"

# ╔═╡ fea56bd9-a789-4563-9e53-1dfcfb9a6417
combine(df_iris, :PetalWidth => sum)

# ╔═╡ c7ccb515-a100-40ad-9da5-5b62c93ab791
md"Using a `GroupedDataFrame` the main difference is that the operations act on the groups. Let's look at grouping by `Species`"

# ╔═╡ fdda2537-96b1-41cd-aadf-401552d2ea61
grp_species = groupby(df_iris, :Species)

# ╔═╡ 1c476593-9abd-4d0b-93ec-3ae908676f59
md"We can then do a simple operation on all of the non-grouping columns (for example)."

# ╔═╡ 72fdbde1-9ed6-4346-804c-5f20ac9a7062
let
	val_cols = valuecols(grp_species)
	combine(grp_species, val_cols .=> (col -> sum(col) / length(col)) .=> Symbol.(val_cols, Ref("_mean")))
end

# ╔═╡ 4188c59e-c78d-44d1-adca-5ef8cc824276
md"## _5. Challenge_

blah do something a bit more elaborate but that doesn't need much"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
CSV = "~0.10.4"
DataFrames = "~1.3.3"
PlutoUI = "~0.7.38"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
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

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings"]
git-tree-sha1 = "873fb188a4b9d76549b81465b1f75c82aaf59238"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.4"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "b153278a25dd42c65abbf4e62344f9d22e59191b"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.43.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "fb5f5316dd3fd4c5e7c30a24d50643b73e37cd40"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.10.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "6c19003824cbebd804a51211fd3bbd81bf1ecad5"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.3"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "129b104185df66e408edd6625d480b7f9e9823a0"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.18"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

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

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "61feba885fac3a407465726d0c330b3055df897f"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.1.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

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

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "1285416549ccfcdf0c50d4997a94331e88d68413"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "670e559e5c8e191ded66fa9ea89c97f10376bb4c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.38"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "28ef6c7ce353f0b35d0df0d5930e0d072c1f5b9b"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.1"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

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

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "6a2f7d70512d205ca8c7ee31bfa9f142fe74310c"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.12"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "216b95ea110b5972db65aa90f88d8d89dcb8851c"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.6"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

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
# ╠═5e7de9f0-c6ee-11ec-36a8-ed4d13eeb11a
# ╠═13ee834a-6af8-453f-b694-69645c88dc8e
# ╟─dffa1033-ba0a-4f6f-a923-fdb51c79326b
# ╠═ade8143e-bc62-45ae-a5f8-a40cd5fa8afd
# ╟─4acfbea8-c62c-4b4b-b638-39d7d3b78dd9
# ╠═37bf8354-ec5f-4257-b5d6-5bea6321e485
# ╟─731e598f-99fb-43e5-a161-8b5bf49ee233
# ╠═e2572630-d888-46bf-849d-72800088d0a6
# ╠═ed2593ed-e341-4ce3-88fa-78ca31da5faa
# ╟─a7b096a1-dbc7-4c98-b7d6-c7d9f6d0b1c3
# ╠═bf451ad3-bd26-4576-b5ca-b70644368c48
# ╟─f17cd6af-7328-496a-aa9c-4d67b97eb785
# ╟─6ade1750-568f-4c59-a709-d94d4d040c6c
# ╠═874dbcea-fac6-4b56-8023-3005b523d125
# ╟─9bc6eae6-7cbf-4bae-9c71-e20dc3a34cf5
# ╠═edaa9d5b-d46f-4c93-8e93-26bcef7bbb9d
# ╟─cad829aa-51c5-4528-9737-192ed3ff51ad
# ╠═1ec739d5-15d5-43ba-b41a-db741c0d675c
# ╟─4a14c49f-b965-4c7c-88e8-2f350847ed88
# ╠═871c71ce-215a-4741-9a86-eb7806a49c85
# ╠═52e4bbd9-c05a-4431-b74b-32d2a7504a10
# ╟─0d43056a-475f-47e3-ae3a-dc32d8e55507
# ╠═9c552660-de93-45db-bce4-eb022e913ce5
# ╠═bc22d6b6-936a-4a6c-a725-e2cc35801ea0
# ╟─9408c7e2-3d8f-4054-8590-e73137dd1319
# ╟─6c2a0e0e-e572-4bb0-808d-c3fea3dcc985
# ╠═e20dda28-8998-4f4a-b2ab-e9df49838af2
# ╟─58e611a9-870c-4d7f-b5bb-68009d68cde8
# ╠═24a2a96e-b15f-4acf-b641-3ca81ca78ddd
# ╟─c07e3cc1-9d75-44e7-82bb-e1d1519ebf7d
# ╠═389407c9-c366-495f-8538-acfef56881d5
# ╠═2a5ec8fc-8dab-4009-ab17-ee374d316df5
# ╠═59e8e6dc-acd2-40f3-86ec-55f0cf6d8e80
# ╠═9ea2b223-621c-4310-9f04-0ca50d90e6b0
# ╟─e50858de-85e5-40f8-9c6a-f69db0b94008
# ╠═83477b92-6bae-4aa0-819f-579ee7fca6f0
# ╠═74f80681-6a15-4417-a468-9cfda3dc1fe0
# ╠═420e409b-e66e-4880-828a-9c77e06491a9
# ╟─35c763f0-8248-49cd-a5e4-118e0743ad73
# ╟─60df44af-03b7-44d2-9415-2d2e0a2913b4
# ╟─1453476d-37d7-491e-9c05-505c721e27f8
# ╠═194a1b6a-c262-44d9-a853-54fae28a13c9
# ╟─2e113e34-b067-4707-81d1-23c5e51bc7d2
# ╠═1c5ae69c-0f73-48c8-aab4-85b4afba1429
# ╠═247e6f2b-da54-4bf4-b941-cefa41dcea40
# ╠═bc9790ab-3aa2-464e-b398-8d76d6d20d91
# ╠═3b050df1-c3df-4984-9cdd-63e79c8e0833
# ╟─87eff33f-e295-43e3-937a-a1b1c66b134c
# ╠═3365aead-c359-4f03-ad35-fe012978dfee
# ╠═b71d6466-2a8b-48cd-9bfe-cbc99c8c97f8
# ╟─249aee53-29e6-4217-bb96-a12ef2246c1b
# ╠═4f0107b6-e710-4f43-a53b-5813ae1ef2d6
# ╟─1a7e4fcb-7814-4954-b72a-e6e669265568
# ╠═b39a9103-8a99-44e7-a0aa-54d0a70dbd5c
# ╠═f44c32a6-e23c-4206-bf48-c1c1c463adef
# ╠═24d23ae9-444d-45da-a776-eca4e1a6bf98
# ╠═fea56bd9-a789-4563-9e53-1dfcfb9a6417
# ╟─c7ccb515-a100-40ad-9da5-5b62c93ab791
# ╠═fdda2537-96b1-41cd-aadf-401552d2ea61
# ╟─1c476593-9abd-4d0b-93ec-3ae908676f59
# ╠═72fdbde1-9ed6-4346-804c-5f20ac9a7062
# ╠═4188c59e-c78d-44d1-adca-5ef8cc824276
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
