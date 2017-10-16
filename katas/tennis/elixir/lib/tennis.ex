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
    %{player1: 0, player2: 0}
  end

  def score(game, player) do
    %{game | player => game[player] + 1}
  end

  def get_winner(game) do
    if (game[:player1] >= 4) do
      :player1
    else
      if (game[:player2] >= 4) do
        :player2
      else
        :none
      end
    end
  end
end
