<?php

class AdventOfCode
{
    public function part1(): int
    {
        $input = self::getInput();
        return $this->calcIncrementing($input);
    }

    public function part2()
    {
        $input = self::getInput();
        $reduce = array_reduce($input, static function ($acc, $item) use ($input): array {
            $offset = $acc[0];
            $list = array_slice($input, $offset, 3);
            return count($list) === 3 ? [++$offset, array_merge($acc[1], [array_sum($list)])] : [++$offset, $acc[1]];
        }, [0, []])[1];
        return $this->calcIncrementing($reduce);
    }

    private function calcIncrementing(array $input): ?int
    {
        return array_reduce($input, static function ($acc, $item): array {
            return $acc[1] !== null && (int)$item > (int)$acc[1] ? [++$acc[0], $item] : [$acc[0], $item];
        }, [0, null])[0];
    }

    private static function getInput(): array
    {
        return explode("\n", file_get_contents("input.txt"));
    }
}


$aoc = new AdventOfCode();
echo 'Part 1: '.$aoc->part1().PHP_EOL;
echo 'Part 2: '.$aoc->part2().PHP_EOL;
