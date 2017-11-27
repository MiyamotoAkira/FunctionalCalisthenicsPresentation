defmodule MarsroverTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  def assert_position_and_direction(rover, position, direction) do
    assert Marsrover.get_position(rover) == position
    assert Marsrover.get_direction(rover) == direction
  end

  @world_size 10

  def execute_commands(x, y, direction, commands, expected_position, expected_direction) do
    Marsrover.create_rover(x, y, direction, @world_size, @world_size)
    |> Marsrover.commands(commands)
    |> assert_position_and_direction(expected_position, expected_direction)
  end

  test "Create rover" do
    execute_commands(5,5, :N, "", %{x: 5, y: 5}, :N)
  end

  test "Move forward" do
    execute_commands(0, 0, :N, "F", %{x: 1, y: 0}, :N)
  end

  test "Move multiple foward" do
    execute_commands(0, 0, :N, "FF", %{x: 2, y: 0}, :N)
  end

  test "Move backwards" do
    execute_commands(1, 0, :N, "B", %{x: 0, y: 0}, :N)
  end

  test "Wrapping north" do
    execute_commands(@world_size - 1, 0, :N, "F", %{x: 0, y: 0}, :N)
  end

  test "Wrapping north after two moves" do
    execute_commands(@world_size - 1, 0, :N, "FF", %{x: 1, y: 0}, :N)
  end

  # test "Wrapping south" do
  #   execute_commands(0, 0, :S, "F", %{x: @world_size - 1, y: 0}, :N)
  # end

  test_with_params "Turning",
  fn (turns, expected_direction) ->
    execute_commands(0, 0, :N, turns, %{x: 0, y: 0}, expected_direction)
  end do
    [
      {"L", :W},
      {"LL", :S},
      {"LLL", :E},
      {"LLLL", :N},
      {"R", :E},
      {"RR", :S},
      {"RRR", :W},
      {"RRRR", :N}
    ]
  end
end
