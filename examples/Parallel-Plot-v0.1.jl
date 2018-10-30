@everywhere include("$(pwd())/examples/Parallel-Plot-Module-v0.1.jl")
using Plots

##22 Seg
function all_remote()
    fetch(@spawn DummyModule.plot_all())
end

function async_remoto_sync_remoto()
    @async fetch(@spawn DummyModule.plot_elip())
    fetch(@spawn DummyModule.plot_hiper())
end

function async_remoto_sync_local()
    @async fetch(@spawn DummyModule.plot_elip())
    DummyModule.plot_hiper()
end

function async_local_async_local()
    @async DummyModule.plot_elip()
    @async DummyModule.plot_hiper()
end

function all_local()
    DummyModule.plot_all()
end

# 23 seg
@time all_local()
# 23 seg
@time all_remote()
# 13 seg
@time async_remoto_sync_remoto()
# 12 seg
@time async_remoto_sync_local()
# 20 seg
@time async_local_async_local()
