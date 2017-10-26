defmodule MarsroverTest do
  use ExUnit.Case

  def assert_position_and_direction(rover, position, direction) do
    assert Marsrover.get_position(rover) == position
    assert Marsrover.get_direction(rover) == direction
  end

  def execute_commands(x, y, direction, commands, expected_position, expected_direction) do
    Marsrover.create_rover(x, y, direction)
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

  test "Turn left" do
    execute_commands(0, 0, :N, "L", %{x: 0, y: 0}, :W)
  end

  test "Turn left twice" do
    execute_commands(0, 0, :N, "LL", %{x: 0, y: 0}, :S)
  end

  test "Turn right" do
    execute_commands(0, 0, :N, "R", %{x: 0, y: 0}, :E)
  end
end
