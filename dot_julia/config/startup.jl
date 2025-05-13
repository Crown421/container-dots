import Pkg
atreplinit() do repl
    try
        @eval using OhMyREPL
    catch e
        @warn "error while importing OhMyREPL" e
    end
end

try
    @eval using Revise
catch e
    @warn "error while importing Revise" e
end

try
    @eval using BenchmarkTools
catch e
    @warn "error while importing BenchmarkTools" e
end
