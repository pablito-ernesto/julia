#Vector con numeros random entre 0 y 1. 10 millones
a = rand(10^7)
println(size(a))
println(sum(a))
@time sum(a)
@time sum(a)
@time sum(a)

#Usando BenchmarkTools se puede correr codigo en otros lenguajes
using Pkg
Pkg.add("BenchmarkTools")
using BenchmarkTools
#Prueba en C
using Libdl
C_code = """
            #include <stddef.h>
            double c_sum(size_t n, double *X) {
                double s = 0.0;
                for (size_t i = 0; i < n; ++i) {
                    s += X[i];
                }
                return s;
            }
        """

const Clib = tempname()   # make a temporary file

# compile to a shared library by piping C_code to gcc
# (works only if you have gcc installed):
open(`gcc -fPIC -O3 -msse3 -xc -shared -o $(Clib * "." * Libdl.dlext) -`, "w") do f
    print(f, C_code)
end
# define a Julia function that calls the C function:
c_sum(X::Array{Float64}) = ccall(("c_sum", Clib), Float64, (Csize_t, Ptr{Float64}), length(X), X)

#is aprox function
println("😸")
1 ≈ 1.00000001

c_sum(a)
c_sum(a) ≈ sum(a)

#TODO como y para que se usa benchmark
c_bench = @benchmark c_sum($a)
println("C: Fastest time was $(minimum(c_bench.times) / 1e6) msec")
#Crear un diccionario y guardar el minimo de tiempo para C
d = Dict()
d["C"] = minimum(c_bench.times) / 1e6

using Plots
#TODO para que se usa el gr()
gr()

using Statistics # bring in statistical support for standard deviations
t = c_bench.times / 1e6 # times in milliseconds
#sacar el minimo de todos los tiempos y la desviacion estandar
#TODO que es la desviacion estandar
m, σ = minimum(t), std(t)

histogram(t, bins=500,
    xlim=(m - 0.01, m + σ),
    xlabel="milliseconds", ylabel="count", label="")


##PYTHON

using Pkg; Pkg.add("PyCall")
using PyCall
# get the Python built-in "sum" function:
pysum = pybuiltin("sum")
pysum(a)
pysum(a) ≈ sum(a)
py_list_bench = @benchmark $pysum($a)
d["Python built-in"] = minimum(py_list_bench.times) / 1e6


##PYTHON NUMPY
using Pkg; Pkg.add("Conda")
using Conda
Conda.add("numpy")

numpy_sum = pyimport("numpy")["sum"]

py_numpy_bench = @benchmark $numpy_sum($a)
numpy_sum(a)
numpy_sum(a) ≈ sum(a)
d["Python numpy"] = minimum(py_numpy_bench.times) / 1e6


##PYTHON HAND WRITTEN
py"""
def py_sum(A):
    s = 0.0
    for a in A:
        s += a
    return s
"""

sum_py = py"py_sum"

py_hand = @benchmark $sum_py($a)
sum_py(a)
sum_py(a) ≈ sum(a)
d["Python hand-written"] = minimum(py_hand.times) / 1e6
