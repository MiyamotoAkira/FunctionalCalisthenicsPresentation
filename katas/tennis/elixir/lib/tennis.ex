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

  def create_game(player1_score, player2_score) do
    %{player1: player1_score, player2: player2_score}
  end

  def score(game, player) do
    %{game | player => game[player] + 1}
  end

  def check_player(game, player) do
    game[player] >= 4
  end

  def get_winner(game) do
    if (check_player(game, :player1)) do
      :player1
    else
      if (check_player(game, :player2)) do
        :player2
      else
        :none
      end
    end
  end
end
