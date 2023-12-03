using BenchmarkTools
using Revise

ROOT = pwd()

# Initiaze module.
# daystr = 01, 02, etc.
function init(daystr)
    mod = include(ROOT * "/day$daystr/run.jl")
    cd(ROOT * "/day$daystr")
    println("Current directory: ", pwd())
    return mod
end

# Run program. This function is expected to be used during development,
# and therefore it only runs part1/2 when the function has already been
# defined. Sometimes there are different test inputs for part1/2 and in
# that case, use the `parts` argument to specify which part you want to
# run for a particular test file.
function run(mod, filename="input.txt", parts=[1, 2])
    if isdefined(mod, :part1) && 1 in parts
        @time println("part1: ", mod.part1(mod.parse_file(filename)))
    elseif 1 in parts
        println("Missing part1 definition")
    end
    if isdefined(mod, :part2) && 2 in parts
        @time println("part2: ", mod.part2(mod.parse_file(filename)))
    elseif 2 in parts
        println("Missing part2 definition")
    end
end

# Benchmark program. This function is expected to run when both part1/2
# are already completed.
function bmk(mod, filename="input.txt")
    data = mod.parse_file(filename)
    @btime mod.part1($data)
    @btime mod.part2($data)
end

# The normal situation is that you have a single test input (test.txt).
# But if there are different test files for part1/2 then put them in
# test1.txt and test2.txt, and they would be executed with part1 and
# part2 functions accordingly.
function runtest()
    files = Dict("test.txt" => [1, 2], "test1.txt" => [1], "test2.txt" => [2])
    for file in sort([k for k in keys(files)])
        if isfile(file)
            println("Testing $file")
            parts = files[file]
            run(file, parts)
        end
    end
end

nothing # no return value after including this file
