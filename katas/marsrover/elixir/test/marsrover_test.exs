defmodule MarsroverTest do
  use ExUnit.Case

  def assert_position_and_direction(rover, position, direction) do
    assert Marsrover.get_position(rover) == position
    assert Marsrover.get_direction(rover) == direction
  end

  test "Create rover" do
    Marsrover.create_rover(5,5,:N)
    |> assert_position_and_direction(%{x: 5, y: 5}, :N)
  end

  test "Move forward" do
    Marsrover.create_rover(0,0,:N)
    |> Marsrover.move("F")
    |> assert_position_and_direction(%{x: 1, y: 0}, :N)
  end

  test "Move multiple foward" do
    Marsrover.create_rover(0,0,:N)
    |> Marsrover.move("FF")
    |> assert_position_and_direction(%{x: 2, y: 0}, :N)
  end

  test "Move backwards" do
    Marsrover.create_rover(1,0,:N)
    |> Marsrover.move("B")
    |> assert_position_and_direction(%{x: 0, y: 0}, :N)
  end

  test "Turn left" do
    Marsrover.create_rover(0,0,:N)
    |> Marsrover.turn("L")
    |> assert_position_and_direction(%{x: 0, y: 0}, :W)
  end

  test "Turn left twice" do
    Marsrover.create_rover(0,0,:N)
    |> Marsrover.turn("LL")
    |> assert_position_and_direction(%{x: 0, y: 0}, :S)
  end

  test "Turn right" do
    Marsrover.create_rover(0, 0, :N)
    |> Marsrover.turn("R")
    |> assert_position_and_direction(%{x: 0, y: 0}, :E)
  end
end
