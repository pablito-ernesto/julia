
using Pkg
Pkg.add("CSV")
Pkg.add("Plots")
Pkg.add("Statistics")
Pkg.add("DataFrames")
Pkg.add("Query")
Pkg.build("CodecZlib")
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
        tipo_vehiculo=lowercase(i.tipo_vehiculo),
        forma_pago=i.forma_pago,
        cantidad_pasos=i.cantidad_pasos
        }
        @collect DataFrame
    end
    return x
end


flujo = "/home/pablo/Dropbox/facultad/julia/TP/code/datos/flujo-vehicular-all-v0.1.csv"
println("procesando ....")
df = CSV.File(flujo) |> DataFrame
println(head(df))

# La cantidad agrupada * columnas del df
println("---cantidad por dia---")
println(by(df, :dia, size))
println("---cantidad por estacion---")
println(by(df, :estacion, size))
println("---cantidad por forma pago---")
println(by(df, :forma_pago, size))
println("---cantidad por tipo vehiculo---")
println(by(df, :tipo_vehiculo, size))

# normalizar dias
# normalizar tipo vehiculo
df = normalize(df)
println("---cantidad por dia---")
println(by(df, :dia, size))
println("---cantidad por tipo vehiculo---")
println(by(df, :tipo_vehiculo, size))

# suma de pasos por tipo de vehiculo
println(by(df, :tipo_vehiculo, d -> DataFrame(pasos = sum(d.cantidad_pasos))))

# suma de cantidad_pasos por dia
pasos_dia = by(df, :dia, d -> DataFrame(pasos = sum(d.cantidad_pasos)))
pasos_dia = sort(pasos_dia,:pasos)
println(pasos_dia)

# dibujar mas copado
plot(size=(800,800),leg=false)
x = pasos_dia.dia
y = pasos_dia.pasos
scatter(x,y,markersize=5)
