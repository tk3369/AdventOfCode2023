module Day04

function parse_file(filename)
    lines = readlines(filename)
    parse(vals) = [Base.parse(Int, x) for x in split(strip(vals), r" +")]
    map(lines) do line
        card, nums = split(line, ": ")
        winning_nums, mine_nums = split(nums, " | ")
        (winning=parse(winning_nums), mine=parse(mine_nums))
    end
end

function score(card)
    wins = count(v in card.winning for v in card.mine)
    return wins > 0 ? 2^(wins - 1) : 0
end

function part1(cards)
    sum(score(card) for card in cards)
end

function part2(cards)
    copies = ones(Int, length(cards))
    for (i, card) in enumerate(cards)
        wins = count(v in card.winning for v in card.mine)
        if wins > 0
            copies[i+1:i+wins] .+= copies[i]
        end
    end
    return sum(copies)
end

end # module
