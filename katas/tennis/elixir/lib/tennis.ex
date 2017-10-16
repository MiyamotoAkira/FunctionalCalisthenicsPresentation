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

  def check_player(game, player_to_win, other_player) do
    game[player_to_win] >= 4 and game[player_to_win] > game[other_player]
  end

  def get_winner(game) do
    cond do
      check_player(game, :player1, :player2) -> :player1
      check_player(game, :player2, :player1) -> :player2
      true ->  :none
    end
  end
end
