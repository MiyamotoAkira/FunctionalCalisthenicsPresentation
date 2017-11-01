defmodule Marsrover do
  @moduledoc """
  Documentation for Marsrover.
  """

  @directions %{N: %{left: :W, right: :E}, W: %{left: :S, right: :N}, E: %{left: :N, right: :S}, S: %{left: :E, right: :W}}
  @moves ["F", "B"]
  @turns ["L", "R"]

  def create_rover(x, y, direction, x_limit, y_limit) do
    %{position: %{x: x, y: y}, direction: direction, world_size: %{x: x_limit, y: y_limit}}
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

  def execute_command(rover, command) when command in @moves do
    %{rover | :position => calculate_new_position(rover[:position], command)}
  end

  def execute_command(rover, command) when command in @turns do
    %{rover | :direction => @directions[rover[:direction]][get_turn(command)]}
  end

  def commands(initial_rover, commands) do
    String.graphemes(commands)
    |> Enum.reduce(initial_rover, fn(command, rover) -> execute_command(rover, command) end)
  end
end
