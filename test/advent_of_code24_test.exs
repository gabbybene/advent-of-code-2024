defmodule AdventOfCode24Test do
  use ExUnit.Case, async: true
  doctest AdventOfCode24

  alias AdventOfCode24.{Day1, Day2, Day3, Day4}

  describe "Day4" do
    # test "for part 1, find_letters/1 returns a map of letters with row and column indices" do
    #   word_search = "MMMSXXMASM\nMSAMXMSMSA"

    #   assert %{
    #            "X" => %{0 => [4, 5], 1 => [4]},
    #            "M" => %{0 => [0, 1, 2, 6, 9], 1 => [0, 3, 5, 7]},
    #            "A" => %{0 => [7], 1 => [2, 9]},
    #            "S" => %{0 => [3, 8], 1 => [1, 6, 8]}
    #          } == Day4.find_letters(word_search)
    # end
    test "to_grid/1 returns grid of positions with character" do
      word_search = "MMMSXXMASM\nMSAMXMSMSA\nAMXSXMAAMM\nMSAMASMSMX\n"

      assert %{
               {0, 0} => "M",
               {0, 1} => "M",
               {0, 2} => "M",
               {0, 3} => "S",
               {0, 4} => "X",
               {0, 5} => "X",
               {0, 6} => "M",
               {0, 7} => "A",
               {0, 8} => "S",
               {0, 9} => "M",
               {1, 0} => "M",
               {2, 0} => "A"
             } = Day4.to_grid(word_search)
    end

    test "for part 1, correctly calculates result" do
      word_search =
        "MMMSXXMASM\nMSAMXMSMSA\nAMXSXMAAMM\nMSAMASMSMX\nXMASAMXAMM\nXXAMMXXAMA\nSMSMSASXSS\nSAXAMASAAA\nMAMMMXMMMM\nMXMXAXMASX"
      assert 18 == Day4.part_1(word_search)
    end

    test "for part 2, correctly calculates result" do
      grid = "MMMSXXMASM\nMSAMXMSMSA\nAMXSXMAAMM\nMSAMASMSMX\nXMASAMXAMM\nXXAMMXXAMA\nSMSMSASXSS\nSAXAMASAAA\nMAMMMXMMMM\nMXMXAXMASX"

      assert 9 == Day4.part_2(grid)
    end
  end

  describe "Day3" do
    test "for part_1, does day 3 calculation" do
      sample_str = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
      assert 161 == Day3.do_day_3_calculation(sample_str)
    end

    test "for part_1, can pull values to multiply from string" do
      sample_str =
        "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))andmul ( 2 , 4 )"

      assert [[2, 4], [5, 5], [11, 8], [8, 5]] == Day3.get_values(sample_str, :part_1)
    end

    test "for part 2, can pull values, and do/don't commands, from string" do
      sample_str = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

      assert [[2, 4], [8, 5]] == Day3.get_values(sample_str, :part_2)
    end

    test "for part 2, handles consecutive `do()`s" do
      sample_str =
        "fdon't(){select(something;from()mul(150,196) ]}(>mul(514,824)where()+mul(332,418)undo()xmul(5,80)do()mul(3,40)"

      assert [[5, 80], [3, 40]] == Day3.get_values(sample_str, :part_2)
    end

    test "for part 2, handles consecutive `don't`()`s" do
      sample_str =
        "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+don't()mul(32,64](mul(11,8)undo()?mul(8,5))"

      assert [[2, 4], [8, 5]] == Day3.get_values(sample_str, :part_2)
    end

    test "for part 2, does correct calculation" do
      sample_str = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
      assert 48 == Day3.do_day_3_calculation(sample_str, :part_2)
    end
  end

  describe "Day2" do
    test "correctly returns the number of safe reports" do
      levels = [
        [7, 6, 4, 2, 1],
        [1, 2, 7, 8, 9],
        [9, 7, 6, 2, 1],
        [1, 3, 2, 4, 5],
        [8, 6, 4, 4, 1],
        [1, 3, 6, 7, 9]
      ]

      assert 2 == Day2.calculate_safe_reports(levels)
    end

    test "for part 2, considers report safe if removal of one element makes it safe" do
      dampened_safe = [1, 3, 2, 4, 5]

      assert Day2.is_safe_with_dampener?(dampened_safe)
    end
  end

  describe "Day1" do
    test "adds up difference of left and right lists" do
      left = [3, 4, 2, 1, 3, 3]
      right = [4, 3, 5, 3, 9, 3]

      assert 11 == Day1.do_calculation(left, right)
    end

    test "part 2 can calculate a similarity score" do
      right = [4, 3, 5, 3, 9, 3]

      frequencies = Enum.frequencies(right)

      assert 9 == Day1.get_similarity_score(3, frequencies)
    end

    test "can calculate part 2" do
      left = [3, 4, 2, 1, 3, 3]
      right = [4, 3, 5, 3, 9, 3]
      assert 31 == Day1.do_part_2_calculation(left, right)
    end
  end
end
