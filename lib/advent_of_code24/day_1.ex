defmodule AdventOfCode24.Day1 do
  def day_1() do
    {left, right} = get_file_data()

    do_calculation(left, right)
  end

  def day_1_part_2() do
    {left, right} = get_file_data()
    do_part_2_calculation(left, right)
  end

  def get_file_data() do
    contents = File.read!("input/day_1.txt")

    row_data =
      String.split(contents, "\n", trim: true)
      |> Enum.map(fn row -> String.split(row, "   ") end)

    left =
      Enum.map(row_data, fn [left, _] -> Integer.parse(left) end)
      |> Enum.map(fn {num, _} -> num end)

    right =
      Enum.map(row_data, fn [_, right] -> Integer.parse(right) end)
      |> Enum.map(fn {num, _} -> num end)

    {left, right}
  end

  def do_part_2_calculation(left, right) do
    frequencies = Enum.frequencies(right)

    similarity_scores =
      Enum.map(left, fn number ->
        get_similarity_score(number, frequencies)
      end)

    Enum.sum(similarity_scores)
  end

  def get_similarity_score(number, frequencies) do
    frequency = Map.get(frequencies, number, 0)

    number * frequency
  end

  def do_calculation(left_list, right_list) do
    sorted_left = Enum.sort(left_list)
    sorted_right = Enum.sort(right_list)

    differences =
      [sorted_left, sorted_right]
      |> Enum.zip_with(fn [left, right] ->
        (right - left) |> abs()
      end)

    Enum.sum(differences)
  end
end
