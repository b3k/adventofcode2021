defmodule AdventOfCode do

  defp input do
    {:ok, data} = File.read("input.txt")
    data
    |> String.split("\n")
    |> Enum.map(fn i -> String.to_integer(i) end)
  end

  defp count_incrementing(list) when is_list(list) do
    list
    |> Enum.reduce({0, nil}, fn i, acc ->
      if elem(acc, 1) != nil and i > elem(acc, 1), do: {elem(acc, 0) + 1, i}, else: {elem(acc, 0), i}
    end)
    |> elem(0)
  end

  def run_part1() do
    input()
    |> count_incrementing()
  end

  def run_part2() do
    input = input()
    input
    |> Enum.reduce({0, []}, fn _i, acc ->
      offset = elem(acc, 0)
      case Enum.slice(input, offset, 3) do
        list when is_list(list) and length(list) == 3 -> {offset+1, [list | elem(acc, 1)]}
        _ -> {offset+1, elem(acc, 1)}
      end
    end)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.map(fn item -> Enum.sum(item) end)
    |> count_incrementing()
  end

end

IO.puts("Part1: #{AdventOfCode.run_part1()}")
IO.puts("Part2: #{AdventOfCode.run_part2()}")
