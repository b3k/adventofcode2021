<?php

$input = explode("\n", file_get_contents("input.txt"));

var_dump(array_reduce($input, static function ($acc, $item): array {
    return $acc[1] !== null && (int)$item > (int)$acc[1] ? [++$acc[0], $item] : [$acc[0], $item];
}, [0, null])[0]);
