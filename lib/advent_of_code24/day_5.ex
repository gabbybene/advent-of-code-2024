defmodule AdventOfCode24.Day5 do
  def parse_input(file_path) do
    file_path
    |> File.read!()
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn group ->
      String.split(group, "\n", trim: true) |> format_group()
    end)
  end

  def part_1() do
    [ordering_rules, pages_to_print] = parse_input("input/day_5.txt")

    part_1(ordering_rules, pages_to_print)
  end

  def part_1(ordering_rules, pages_to_print) do
    valid_instructions =
      pages_to_print
      |> Enum.filter(&is_valid_instruction?(&1, ordering_rules))

    valid_instructions
    |> Enum.map(&get_middle_value/1)
    |> Enum.sum()
  end

  def part_2() do
    [ordering_rules, pages_to_print] = parse_input("input/day_5.txt")

    part_2(ordering_rules, pages_to_print)
  end

  def part_2(ordering_rules, pages_to_print) do
    invalid_instructions =
      Enum.filter(pages_to_print, &is_invalid_instruction?(&1, ordering_rules))

    sorted_instructions =
      invalid_instructions
      |> Enum.map(fn instruction ->
        Enum.reduce(instruction, [], fn num, sorted_list ->
          insert(sorted_list, num, ordering_rules)
        end)
      end)

    sorted_instructions
    |> Enum.map(&get_middle_value/1)
    |> Enum.sum()
  end

  def get_middle_value(instruction) do
    mid_index = length(instruction) |> div(2)
    Enum.at(instruction |> Enum.to_list(), mid_index)
  end

  def is_valid_instruction?(instruction, rules) do
    applicable_rules =
      Enum.filter(rules, fn {first, last} ->
        first in instruction and
          last in instruction
      end)

    Enum.all?(applicable_rules, &in_valid_order?(&1, instruction))
  end

  def in_valid_order?({first, last} = _rule, {a, b}) do
    {first, last} == {a, b}
  end

  def in_valid_order?({first, last}, instruction) do
    first_index = Enum.find_index(instruction, &(&1 == first))
    last_index = Enum.find_index(instruction, &(&1 == last))

    is_nil(first_index) or is_nil(last_index) or last_index > first_index
  end

  defp insert([], num, _), do: [num]

  defp insert([head | tail], number, ordering_rules) do
    if {head, number} in ordering_rules do
      # if correct order, insert number after head
      [head | insert(tail, number, ordering_rules)]
    else
      # else, swap number
      [number, head | tail]
    end
  end

  defp is_invalid_instruction?(instruction, rules) do
    not is_valid_instruction?(instruction, rules)
  end

  defp format_group([<<_, _, "|", _, _>> | _] = rules) do
    rules
    |> Enum.map(fn rule ->
      [first, last] = String.split(rule, "|", trim: true)
      {String.to_integer(first), String.to_integer(last)}
    end)
  end

  defp format_group(pages_to_print) do
    pages_to_print
    |> Enum.map(fn list ->
      list
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
