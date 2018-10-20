using Pkg
Pkg.add("BenchmarkTools")
using BenchmarkTools
d = Dict()

#Vector con numeros random entre 0 y 1. 10 millones
a = rand(10^7)
println(size(a))
println(sum(a))
@time sum(a)

#TODO Ver como sacarle jugo a benchmark
#EJEMPLO JULIA: "FUNCION SUM"
j_bench = @benchmark sum($a)
d["Julia built-in"] = minimum(j_bench.times) / 1e6


#EJEMPLO JULIA: "A MANO"
function mysum(A)
    s = 0.0
    for a in A
        s += a
    end
    s
end
j_bench_hand = @benchmark mysum($a)
d["Julia hand-written"] = minimum(j_bench_hand.times) / 1e6

#EJEMPLO JULIA: "A MANO CON simd(?)"
function mysum_simd(A)
    s = 0.0 # s = zero(eltype(A))
    @simd for a in A
        s += a
    end
    s
end
j_bench_hand_simd = @benchmark mysum_simd($a)
d["Julia hand-written simd"] = minimum(j_bench_hand_simd.times) / 1e6


#EJEMPLO EN C: "A MANO"
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
open(`gcc -fPIC -O3 -msse3 -xc -shared -o $(Clib * "." * Libdl.dlext) -`, "w") do f
    print(f, C_code)
end
c_sum(X::Array{Float64}) = ccall(("c_sum", Clib), Float64, (Csize_t, Ptr{Float64}), length(X), X)
c_bench = @benchmark c_sum($a)
d["C"] = minimum(c_bench.times) / 1e6

#PARENTESIS "ISAPPROX"
println("😸")
1 ≈ 1.00000001
c_sum(a)
c_sum(a) ≈ sum(a)
#FIN DE PARENTESIS "ISAPPROX"

##EJEMPLO PYTHON: "PYSUM"
using Pkg
ENV["PYTHON"]="/usr/bin/python"
Pkg.add("PyCall")
Pkg.build("PyCall")
using PyCall
pysum = pybuiltin("sum")
pysum(a) ≈ sum(a)
py_list_bench = @benchmark $pysum($a)
d["Python built-in"] = minimum(py_list_bench.times) / 1e6

##EJEMPLO PYTHON: "PYTHON NUMPY"
using Pkg
Pkg.add("Conda")
using Conda
Conda.add("numpy")
numpy_sum = pyimport("numpy")["sum"]
py_numpy_bench = @benchmark $numpy_sum($a)
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
sum_py(a) ≈ sum(a)
d["Python hand-written"] = minimum(py_hand.times) / 1e6


using Plots
#GR se usa para dar un frame a los graficos
gr()
using Statistics # bring in statistical support for standard deviations
t = c_bench.times / 1e6 # times in milliseconds
#sacar el minimo de todos los tiempos y la desviacion estandar
#std es la desviacion estandar
m, σ = minimum(t), std(t)

histogram(t, bins=500,
    xlim=(m - 0.01, m + σ),
    xlabel="milliseconds", ylabel="count", label="")

for (key, value) in sort(collect(d), by=last)
    println(rpad(key, 25, "."), lpad(round(value; digits=1), 6, "."))
end
