defmodule Marsrover do
  @moduledoc """
  Documentation for Marsrover.
  """

  @directions %{N: %{left: :W, right: :E}, W: %{left: :S}}

  def create_rover(x, y, direction) do
    %{position: %{x: x, y: y}, direction: direction}
  end

  def get_position(rover) do
    rover[:position]
  end

  def get_direction(rover) do
    rover[:direction]
  end

  def calculate_new_position(position, movement) do
    case movement do
      "F" ->  %{position | :x => position[:x] + 1}
      "B" ->  %{position | :x => position[:x] - 1}
    end
  end

  def get_turn(turn) do
    case turn do
      "L" -> :left
      "R" -> :right
    end
  end

  def move(rover, movement) do
    String.graphemes(movement)
    |> Enum.reduce(rover, fn(move, acc) ->  %{acc | :position => calculate_new_position(acc[:position], move)} end)
  end

  def turn(rover, turns) do
    String.graphemes(turns)
    |> Enum.reduce(rover, fn(turn, acc) -> %{ acc | :direction => @directions[acc[:direction]][get_turn(turn)]} end)
  end
end
