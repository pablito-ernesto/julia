using Plots

# n = 100
# ts = range(-50, stop=50, length=100)
# x = ts .* map(cos,ts)
# y = ts .* map(sin,ts)
for x = -50:50, y = -50:50
    plot(x,y,(x^2 - y^2),leg=false,w=1)
end
