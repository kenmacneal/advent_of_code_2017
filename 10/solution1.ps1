$lengths = 102,255,99,252,200,24,219,57,103,2,226,254,1,0,69,216

$list = 0..255

$curPos = 0
$skipSize = 0

    foreach ($len in $lengths)
    {
        # Get the indexes of items to reverse, handling wraparound
        $indexesToReverse = for ($i=0; $i -lt $len; $i++){ ($curPos + $i) % $list.Count }

        # Swap first and last, seconds and penultimate, third and .. etc unto the middle one: 0,-1  1,-2, 2,-3 etc.
        for ($i=0; $i -lt [int]($indexesToReverse.Count/2); $i++)
        {
            $temp = $list[$indexesToReverse[$i]]
            $list[$indexesToReverse[$i]] = $list[$indexesToReverse[0-($i+1)]]
            $list[$indexesToReverse[0-($i+1)]] = $temp
        }

        $curPos = ($curPos + $len + $skipSize) % $list.count
        $skipSize++
    }
    # Part 1 output
     $list[0] * $list[1]

     #from https://www.reddit.com/r/adventofcode/comments/7irzg5/2017_day_10_solutions/dr12q92/