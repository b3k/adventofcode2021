defmodule AdventOfCode do
  defp input do
    {:ok, data} = File.read("input.txt")

    data
    |> String.split("\n")
  end

  defp count_depth_and_position(list) when is_list(list) do
    list
    |> Enum.reduce({0, 0}, fn i, acc ->
      case parse_command(i) do
        {:up, value} -> {elem(acc, 0), elem(acc, 1) - value}
        {:down, value} -> {elem(acc, 0), elem(acc, 1) + value}
        {:forward, value} -> {elem(acc, 0) + value, elem(acc, 1)}
        _ -> acc
      end
    end)
    |> multiply()
  end

  defp count_depth_and_position_with_aim(list) when is_list(list) do
    list
    |> Enum.reduce({0, 0, 0}, fn i, acc ->
      case parse_command(i) do
        {:up, value} ->
          {elem(acc, 0), elem(acc, 1), elem(acc, 2) - value}

        {:down, value} ->
          {elem(acc, 0), elem(acc, 1), elem(acc, 2) + value}

        {:forward, value} ->
          {
            elem(acc, 0) + value,
            elem(acc, 1) + elem(acc, 2) * value,
            elem(acc, 2)
          }

        _ ->
          acc
      end
    end)
    |> multiply()
  end

  defp multiply({v1, v2}) when is_integer(v1) and is_integer(v2) do
    v1 * v2
  end

  defp multiply({v1, v2, _}) do
    multiply({v1, v2})
  end

  defp parse_command("forward " <> value) do
    {:forward, String.to_integer(value)}
  end

  defp parse_command("up " <> value) do
    {:up, String.to_integer(value)}
  end

  defp parse_command("down " <> value) do
    {:down, String.to_integer(value)}
  end

  defp parse_command(_) do
    {:unknown}
  end

  def run_part1() do
    input()
    |> count_depth_and_position()
  end

  def run_part2() do
    input()
    |> count_depth_and_position_with_aim()
  end
end

IO.puts("Part1: #{AdventOfCode.run_part1()}")
IO.puts("Part2: #{AdventOfCode.run_part2()}")
