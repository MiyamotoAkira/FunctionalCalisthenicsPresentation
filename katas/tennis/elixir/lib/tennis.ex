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
    :player1
  end

end
