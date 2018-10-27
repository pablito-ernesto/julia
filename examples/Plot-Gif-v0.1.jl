using Plots

function parabol_hiperbol!(x::Int64, y::Int64)
    x^2 - y^2
end

function parabol_elip!(x::Int64, y::Int64)
    x^2 + y^2
end

function plot_elip()
    pe = plot3d(1, xlim=(-50,50), ylim=(-50,500), zlim=(-2500,2500),
                    title = "Paraboloide Elíptico", marker = 1)
    @gif for x = -50:50, y = -50:50
        z = parabol_elip!(x,y)
        push!(pe, float(x), float(y), float(z))
    end every 100
end

function plot_hiper()
    # initialize a 3D plot with 1 empty series
    ph = plot3d(1, xlim=(-50,50), ylim=(-50,500), zlim=(-2500,2500),
                    title = "Paraboloide Hiperbólico", marker = 1)
    @gif for x = -50:50, y = -50:50
        z = parabol_hiperbol!(x,y)
        push!(ph, float(x), float(y), float(z))
    end every 100
end

function plot_all()
    plot_elip()
    plot_hiper()
end

plot_all()
