defmodule AdventOfCode do

  def run() do
    {:ok, data} = File.read("input.txt")
    data
    |> String.split("\n")
    |> Enum.map(fn i -> String.to_integer(i) end)
    |> Enum.reduce({0, nil}, fn i, acc ->
      if elem(acc, 1) != nil and i > elem(acc, 1), do: {elem(acc, 0) + 1, i}, else: {elem(acc, 0), i}
    end)
    |> elem(0)
    |> IO.puts
  end

end

AdventOfCode.run()
