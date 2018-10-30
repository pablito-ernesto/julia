n = m = 10^3
@time r = @spawn rand(m,n)
@time l =  rand(m,n)

@time r[1] + 1
@time l[1] + 1
