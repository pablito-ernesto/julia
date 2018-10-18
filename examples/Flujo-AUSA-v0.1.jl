
using Pkg
# Pkg.add("CSV")
# Pkg.add("Plots")
# Pkg.add("Statistics")
# Pkg.add("DataFrames")
# Pkg.add("Query")
# Pkg.build("CodecZlib")
using CSV
using DataFrames
using Query
using Plots
using Statistics

function normalize(df::DataFrame)
    x = @from i in df begin
        @select {periodo = i.periodo,
        fecha=i.fecha,
        dia=lowercase(i.dia),
        hora_desde=i.hora,
        hora_hasta=i.hora_fin,
        estacion=i.estacion,
        tipo_vehiculo=i.tipo_vehiculo,
        forma_pago=i.forma_pago,
        cantidad_pasos=i.cantidad_pasos
        }
        @collect DataFrame
    end
    return x
end


file = "/home/pablo/Dropbox/facultad/julia/TP/code/datos/flujo-2018.csv"
println("procesando ....")
df = CSV.File(file) |> DataFrame
println(head(df))
df = normalize(df)
println(head(df))
# La cantidad agrupada * columnas del df
println(by(df, :dia, size))
# promedio de cantidad_pasos por dia
println(by(df, :dia, dfs -> mean(dfs.cantidad_pasos)))

plot(size=(800,800),leg=false)
x = df.dia
y = df.cantidad_pasos
scatter(x,y,markersize=3)
