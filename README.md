# AdventOfCode2023

Workflow for a new day
1. Create a new day folder using template folder dayXX
2. Change directory to the new folder
3. Use `includet("run.jl")` to watch changes during problem solving

Finalize day after problem is solved
1. Convert run.jl file to a module (uncomment first & last lines)
2. Use init, run, and bmk functions to re-run and benchmark logic
