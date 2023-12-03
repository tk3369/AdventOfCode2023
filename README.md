# AdventOfCode2023

## Performance
While not a primary concern for me, I'm keeping track and I may come back and optimize code later.

| Day | Part 1    | Part 2    | Notes                    |
| --- | --------- | --------- | ------------------------ |
| 1   | 69.500 μs | 2.644 ms  | Find digits              |
| 2   | 31.750 μs | 17.708 μs | Parsing, finding min/max |
| 3   | 11.438 ms | 19.745 ms | Parsing, collision       |

## Workflow for a new day
1. Create a new day folder using template folder `dayXX`
2. Change directory to the new folder
3. Use `includet("run.jl")` to watch changes during problem solving

## Finalize day after problem is solved
1. Convert run.jl file to a module (uncomment first & last lines)
2. Use `init`, `run`, and `bmk` functions to re-run and benchmark logic

## Sample commands

```bash
# Run a single day
julia --project=. -e 'include("main.jl"); run(init("03"))'

# Benchmark a single day
julia --project=. -e 'include("main.jl"); bmk(init("03"))'
```
