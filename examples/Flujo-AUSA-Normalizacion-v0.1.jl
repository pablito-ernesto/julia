
using Pkg
# Pkg.add("CSV")
# Pkg.add("Plots")
# Pkg.add("Statistics")
# Pkg.add("DataFrames")
# Pkg.add("Query")
# Pkg.build("CodecZlib")
using CSV
using DataFrames

# sed -i -e 's/;/,/g' flujo-vehicular-2016.csv
file = "/home/pablo/Dropbox/facultad/julia/TP/code/datos/flujo-vehicular-all.csv"
file_o = "/home/pablo/Dropbox/facultad/julia/TP/code/datos/flujo-vehicular-all-v0.1.csv"

df = CSV.File(file) |> DataFrame
println(head(df))

# df = permutecols!(df, [1,2,5,3,4,6,7,8,9]);
# println(head(df))

df = rename(x -> Symbol(lowercase(string(x))), df)
println(head(df))

CSV.write(file_o, df)
