defmodule Tennis do
  @moduledoc """
  Documentation for Tennis.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Tennis.hello
      :world

  """
  def create_game do
    %{player1: 0, player2: 0}.
  end

  def score(game, player) do
    if player == :player1 do
      %{game | :player1 => game[:player1] + 1}
    else
      %{game | :player2 => game[:player2] + 1}
    end
  end

  def get_winner(game) do
    :player1
  end

end
