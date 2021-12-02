<?php

class AdventOfCode
{
    public function part1(): int
    {
        $input = self::getInput();
        $depth = $this->calcDepth($input);
        $position = $this->calcPosition($input);
        return $depth*$position;
    }

    public function part2(): int
    {
        $input = self::getInput();
        $data = $this->calcDepthAndPosition($input);
        return $data[0]*$data[1];
    }

    private function calcDepthAndPosition(array $input): array
    {
        // [position, depth, aim]
        return array_reduce($input, static function ($acc, $item): array {
            if (substr($item, 0, 7) === 'forward') {
                $value = intval(substr($item, 8));
                $acc[0] += $value;
                $acc[1] += $acc[2]*$value;
            } elseif (substr($item, 0, 4) === 'down') {
                $acc[2] += intval(substr($item, 5));
            } elseif (substr($item, 0, 2) === 'up') {
                $acc[2] -= intval(substr($item, 3));
            }
            return $acc;
        }, [0,0,0]);
    }

    private function calcPosition(array $input): int
    {
        return array_reduce($input, static function ($acc, $item): int {
            if (substr($item, 0, 7) === 'forward') {
                $acc += intval(substr($item, 8));
            }
            return $acc;
        }, 0);
    }

    private function calcDepth(array $input): int
    {
        return array_reduce($input, static function ($acc, $item): int {
            if (substr($item, 0, 4) === 'down') {
                $acc += intval(substr($item, 5));
            } elseif (substr($item, 0, 2) === 'up') {
                $acc -= intval(substr($item, 3));
            }
            return $acc;
        }, 0);
    }

    private static function getInput(): array
    {
        return explode("\n", file_get_contents("input.txt"));
    }
}


$aoc = new AdventOfCode();
echo 'Part 1: '.$aoc->part1().PHP_EOL;
echo 'Part 2: '.$aoc->part2().PHP_EOL;
