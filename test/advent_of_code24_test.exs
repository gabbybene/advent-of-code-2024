defmodule AdventOfCode24Test do
  use ExUnit.Case, async: true
  doctest AdventOfCode24

  alias AdventOfCode24.{Day1, Day2, Day3, Day4, Day5}

  describe "Day5" do
    setup ctx do
      rules =
        Map.get(ctx, :rules, [
          {47, 53},
          {97, 13},
          {97, 61},
          {97, 47},
          {75, 29},
          {61, 13},
          {75, 53},
          {29, 13},
          {97, 29},
          {53, 29},
          {61, 53},
          {97, 53},
          {61, 29},
          {47, 13},
          {75, 47},
          {97, 75},
          {47, 61},
          {75, 61},
          {47, 29},
          {75, 13},
          {53, 13}
        ])

      [rules: rules]
    end

    @tag rules: [{61, 29}]
    test "in_valid_order?/2 returns true when both  numbers are present and in correct order",
         ctx do
      valid_instruction = [75, 47, 61, 53, 29]

      assert Day5.in_valid_order?(List.first(ctx.rules), valid_instruction)
    end

    @tag rules: [{29, 61}]
    test "in_valid_order?/2 returns false when both numbers are present, but out of order", ctx do
      invalid_instruction = [75, 47, 61, 53, 29]

      refute Day5.in_valid_order?(List.first(ctx.rules), invalid_instruction)
    end

    test "is_valid_instruction?/2 returns true for list of instructions that is in a correct order",
         ctx do
      valid_instruction = [75, 47, 61, 53, 29]
      # is correct because numbers are in valid order and numbers without instruction are ignored

      assert Day5.is_valid_instruction?(valid_instruction, ctx.rules)
    end

    test "is_valid_instruction?/2 returns false for invalid list of instructions", ctx do
      invalid_instruction = [75, 97, 47, 61, 53]

      refute Day5.is_valid_instruction?(invalid_instruction, ctx.rules)
    end

    test "middle_index works" do
      instruction = [75, 97, 47, 61, 53]

      assert 47 == Day5.get_middle_value(instruction)
    end

    test "part_1", ctx do
      instructions = [
        [75, 47, 61, 53, 29],
        [97, 61, 53, 29, 13],
        [75, 29, 13],
        [75, 97, 47, 61, 53],
        [61, 13, 29],
        [97, 13, 75, 29, 47]
      ]

      assert 143 == Day5.part_1(ctx.rules, instructions)
    end

    test "part_2", ctx do
      instructions = [
        [75, 47, 61, 53, 29],
        [97, 61, 53, 29, 13],
        [75, 29, 13],
        [75, 97, 47, 61, 53],
        [61, 13, 29],
        [97, 13, 75, 29, 47]
      ]

      assert 123 == Day5.part_2(ctx.rules, instructions)
    end
  end

  describe "Day4" do
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
      grid =
        "MMMSXXMASM\nMSAMXMSMSA\nAMXSXMAAMM\nMSAMASMSMX\nXMASAMXAMM\nXXAMMXXAMA\nSMSMSASXSS\nSAXAMASAAA\nMAMMMXMMMM\nMXMXAXMASX"

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
