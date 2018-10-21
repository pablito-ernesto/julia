using Plots


# initialize a 3D plot with 1 empty series
plt = plot3d(1, xlim=(-50,50), ylim=(-50,500), zlim=(-2500,2500),
                title = "Paraboloide Hiperbólico", marker = 1)

function parabol_hiperbol!(x::Int64, y::Int64)
    x^2 - y^2
end
parabol_hiperbol!(2,1)

@gif for x = -50:50, y = -50:50
    z = parabol_hiperbol!(x,y)
    push!(plt, float(x), float(y), float(z))
end every 100
