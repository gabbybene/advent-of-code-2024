defmodule AdventOfCode24.Day2 do
  def part_1() do
    levels = get_data()

    calculate_safe_reports(levels)
  end

  def part_2() do
    levels = get_data()

    calculate_safe_reports_with_dampener(levels)
  end

  def get_data() do
    file_contents = File.read!("input/day_2.txt")

    file_contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      String.split(row, " ", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
  end

  def calculate_safe_reports_with_dampener(levels) do
    Enum.count(levels, &is_safe_with_dampener?/1)
  end

  def is_safe_with_dampener?(level) do
    levels_less_one_elem =
      Enum.map(0..length(level), &List.delete_at(level, &1))

    Enum.any?(levels_less_one_elem, &is_safe?/1)
  end

  def calculate_safe_reports(levels) do
    Enum.count(levels, &is_safe?/1)
  end

  def is_safe?([a, a | _rest]), do: false

  def is_safe?([first, next | tail]) do
    multiplier = if next - first > 0, do: 1, else: -1
    is_safe?([first, next | tail], multiplier)
  end

  def is_safe?([first, next | tail], multiplier) do
    ((next - first) * multiplier) in 1..3 && is_safe?([next | tail], multiplier)
  end

  def is_safe?([_], _), do: true
end
