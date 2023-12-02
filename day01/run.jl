function parse(filename)
    return readlines(filename)
end

function first_digit(s::AbstractString)
    for c in s
        isdigit(c) && return c
    end
    error("no digit found")
end

function calibration_value(s::AbstractString)
    val_str = first_digit(s) * first_digit(reverse(s))
    return Base.parse(Int, val_str)
end

function part1(filename)
    return sum(calibration_value.(parse(filename)))
end

# part 2

function first_digit(s::AbstractString, normal::Bool)
    digit_strings = [
        "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"
    ]
    digit_normal_map = [(s, string(i)) for (i, s) in enumerate(digit_strings)]
    digit_reverse_map = [(reverse(s), string(i)) for (i, s) in enumerate(digit_strings)]
    for i in 1:length(s)
        isdigit(s[i]) && return s[i]
        digit_map = normal ? digit_normal_map : digit_reverse_map
        for (digit_string, digit_value) in digit_map
            remaining_length = length(s) - i + 1
            match_length = length(digit_string)
            if match_length <= remaining_length && s[i:i+match_length-1] == digit_string
                return digit_value
            end
        end
    end
    error("unable to find digit")
end

function calibration_value2(s::AbstractString)
    val_str = first_digit(s, true) * first_digit(reverse(s), false)
    return Base.parse(Int, val_str)
end

function part2(filename)
    return sum(calibration_value2.(parse(filename)))
end

function run_day()
    println("part1: ", part1("input.txt"))
    println("part2: ", part2("input.txt"))
end
