defmodule AdventOfCode24.Day3 do
  def part_1() do
    "day_3.txt"
    |> File.read!()
    |> String.replace("\n", "")
    |> do_day_3_calculation()
  end


  def part_2() do
    "input/day_3.txt"
    |> File.read!()
    |> do_day_3_calculation(:part_2)
  end

  def do_day_3_calculation(data, version \\ :part_1) do
    values = get_values(data, version)

    values
    |> Enum.map(fn [a, b] -> a * b end)
    |> Enum.sum()
  end

  def get_values(string, :part_2) do
    string
    |> String.replace("\n", "")
    |> then(fn str -> Regex.replace(~r/don\'t\(\).*?do\(\)/, str, "") end)
    |> get_values(:part_1)
  end

  def get_values(string, _part_1) do
    valid_commands = Regex.scan(~r/mul\(\d+,\d+\)/, string)

    valid_commands
    |> Enum.map(fn [mul] ->
      Regex.run(~r/\d+,\d+/, mul)
      |> Enum.at(0)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
