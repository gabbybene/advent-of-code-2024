defmodule AdventOfCode24.Day4 do
  @search_word ~w[X M A S]

  def part_1() do
    "day_4.txt"
    |> File.read!()
    |> part_1()
  end

  def part_1(input_data) do
    grid_data = to_grid(input_data)

    Enum.reduce(grid_data, 0, fn {position, _}, count ->
      search_directions()
      |> Enum.reduce(count, fn direction, count ->
        case matches_word?(grid_data, @search_word, position, direction) do
          true -> count + 1
          false -> count
        end
      end)
    end)
  end

  def part_2() do
    "input/day_4.txt"
    |> File.read!()
    |> part_2()
  end

  def part_2(input_data) do
    grid_data = to_grid(input_data)

    Enum.reduce(grid_data, 0, fn {position, _}, count ->
      diagonal_directions()
      |> Enum.reduce(count, fn direction, count ->
        case matches_x_mas?(grid_data, position, direction) do
          true -> count + 1
          false -> count
        end
      end)
    end)
  end

  @doc """
  If `character` is in grid data at position,
  adjust position by direction, then matches_word?(grid_data, rest_of_characters, new_position, direction)

  If, at any point, the next expcted character is not found, return false
  """
  def matches_word?(grid_data, [character | rest_of_characters], position, direction) do
    case character_found?(grid_data, character, position) do
      true ->
        new_position = adjust_position(position, direction)
        matches_word?(grid_data, rest_of_characters, new_position, direction)

      _ ->
        false
    end
  end

  def matches_word?(_, [], _, _), do: true

  @doc """
  If diagonally-positioned characters are M A S, returns true
  """
  def matches_x_mas?(grid_data, position, direction) do
    matches_mas?(grid_data, position, direction) and
      matches_mas?(grid_data, position, rotate_90(direction))
  end

  def matches_mas?(grid_data, position, direction) do
    opposing_diagonal = opposing_diagonal(direction)

    # diagonally is M
    # 180 degrees from M direction is S
    get_character(grid_data, position) == "A" and
      get_character(grid_data, adjust_position(position, direction)) == "M" and
      get_character(grid_data, adjust_position(position, opposing_diagonal)) == "S"
  end

  defp get_character(grid_data, position) do
    Map.get(grid_data, position)
  end

  def character_found?(grid_data, character, position) do
    Map.get(grid_data, position) == character
  end

  defp opposing_diagonal({x, y}), do: {-x, -y}

  defp rotate_90({x, y}), do: {y, -x}

  def adjust_position({curr_row, curr_col} = _position, {row_adjust, col_adjust} = _direction) do
    {curr_row + row_adjust, curr_col + col_adjust}
  end

  def to_grid(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line_data, row_num} ->
      line_data
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {letter, col_num} ->
        position = {row_num, col_num}
        [{position, letter}]
      end)
    end)
    |> Map.new()
  end

  @doc """
  For part 1, to search in any direction
  (forwards, backwards, up, down, diagonal in any direction)
  """
  def search_directions() do
    [
      {0, 1},
      {0, -1},
      {-1, 0},
      {1, 0},
      {1, 1},
      {1, -1},
      {-1, 1},
      {-1, -1}
    ]
  end

  @doc """
  Diagonal directions only
  """
  def diagonal_directions() do
    [
      {1, 1},
      {1, -1},
      {-1, 1},
      {-1, -1}
    ]
  end
end
