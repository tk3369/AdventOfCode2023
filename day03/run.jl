module Day03

CI = CartesianIndex

function parse_file(filename)
    lines = readlines(filename)
    syms = CartesianIndex[]
    dct = Dict{CartesianIndices,Int}()
    for (row, line) in enumerate(lines)
        parse_engine_parts!(dct, line, row)
        parse_symbols!(syms, line, row)
    end
    return dct, syms
end

function parse_symbols!(syms, line, row)
    sym_indices = findall(c -> c != '.' && !isdigit(c), line)
    append!(syms, [CartesianIndex(i, row) for i in sym_indices])
end

function parse_engine_parts!(dct, line, row)
    val = 0
    local idx_start, idx_end
    for (i, c) in enumerate(line)
        if isdigit(c)
            digit = c - '0'
            if val == 0  # new number
                val = digit
                idx_start = i
            else
                val *= 10
                val += digit
            end
        else # either . or a symbol
            if val > 0
                idx_end = i - 1
                dct[CartesianIndices((idx_start:idx_end, row:row))] = val
                val = 0
            end
        end
    end
    if val > 0 # number appearing at end of line
        idx_end = length(line)
        dct[CartesianIndices((idx_start:idx_end, row:row))] = val
    end
    return dct
end

function overlap(sym_position, num_block)
    surroundings = Ref(sym_position) .+
                   [CI(-1, -1), CI(-1, 0), CI(-1, 1), CI(1, -1), CI(1, 0), CI(1, 1), CI(0, 1), CI(0, -1)]
    return any(in.(surroundings, Ref(num_block)))
end

function find_gears(sym_position, dct)
    blocks = [k for k in keys(dct)]
    gears = findall(num_block -> overlap(sym_position, num_block), blocks)
    return length(gears) == 2 ? dct[blocks[gears[1]]] * dct[blocks[gears[2]]] : 0
end

function debug(result, row)
    return sort([r for r in result if r[1].indices[2][begin] == row]; by=x -> x[1].indices[1])
end

function part1(parsed_data)
    dct, syms = parsed_data
    # result = []
    answer = 0
    for (num_block, val) in dct
        for sym_position in syms
            if overlap(sym_position, num_block)
                # push!(result, (num_block, val, sym_position))
                answer += val
            end
        end
    end
    # return result, answer
    return answer
end

function part2(parsed_data)
    dct, syms = parsed_data
    return sum(find_gears(s, dct) for s in syms)
end

end # module
