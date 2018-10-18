
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
file_o = "/home/pablo/Dropbox/facultad/julia/TP/code/datos/flujo-vehicular-all.csv"
file_2015 = "/home/pablo/Dropbox/facultad/julia/TP/code/datos/flujo-vehicular-2015.csv"
file_2016 = "/home/pablo/Dropbox/facultad/julia/TP/code/datos/flujo-vehicular-2016-ok.csv"
file_2017 = "/home/pablo/Dropbox/facultad/julia/TP/code/datos/flujo-vehicular-2017-ok.csv"
file_2018 = "/home/pablo/Dropbox/facultad/julia/TP/code/datos/flujo-vehicular-2018.csv"


df_2015 = CSV.File(file_2015) |> DataFrame
CSV.write(file_o, df_2015)
df_2016 = CSV.File(file_2016) |> DataFrame
CSV.write(file_o, df_2016, append=true)
df_2017 = CSV.File(file_2017) |> DataFrame
CSV.write(file_o, df_2017, append=true)
df_2018 = CSV.File(file_2018) |> DataFrame
CSV.write(file_o, df_2018, append=true)
