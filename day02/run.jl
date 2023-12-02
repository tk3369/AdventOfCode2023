module Day02
struct CubeSet
    num::Int
    color::String
end

struct Turn
    cube_sets::Vector{CubeSet}
end

struct Game
    id::Int
    turns::Vector{Turn}
end

# parse a single turn
# x <color>, y <color>, ...
function parse_turn(str)
    spec = split(str, ", ")
    matches = [match(r"(\d+) (.+)", cube) for cube in spec]
    return Turn([CubeSet(Base.parse(Int, m[1]), m[2]) for m in matches])
end

# parse a complete line
function parse_line(line)
    game_str, turns_str = split(line, ": ")
    id = Base.parse(Int, split(game_str, " ")[2])
    turns = parse_turn.(split(turns_str, "; "))
    return Game(id, turns)
end

function parse_file(filename)
    lines = readlines(filename)
    return parse_line.(lines)
end

function is_possible(cs::CubeSet)
    if cs.color == "red"
        return cs.num <= 12
    elseif cs.color == "green"
        return cs.num <= 13
    else
        return cs.num <= 14
    end
end

function is_possible(turn::Turn)
    return all(is_possible.(turn.cube_sets))
end

function is_possible(game::Game)
    return all(is_possible.(game.turns))
end

function score(games::Vector{Game})
    return sum(g.id for g in games)
end

function part1(parsed_data)
    games = parsed_data
    return score(games[is_possible.(games)])
end

function get_number(turn::Turn, color::String)
    for cs in turn.cube_sets
        cs.color == color && return cs.num
    end
    return 0
end

function find_fewest_possible(game::Game)
    red = maximum(get_number.(game.turns, "red"))
    green = maximum(get_number.(game.turns, "green"))
    blue = maximum(get_number.(game.turns, "blue"))
    return red * green * blue
end

function part2(parsed_data)
    return sum(find_fewest_possible.(parsed_data))
end

end
