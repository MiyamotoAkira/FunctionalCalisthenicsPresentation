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
    (game[player_to_win] == 4
      and game[player_to_win] > game[other_player])
    or
    (game[player_to_win] > 4
      and (game[player_to_win] > game[other_player] + 1))
  end

  def score_as_string(score) do
    case score do
      0 -> "love"
      1 -> "fifteen"
      2 -> "thirty"
      3 -> "forty"
    end
  end
  def report_score(game) do
    case {game[:player1], game[:player2]} do
      {0, 0} -> "love all"
      {a, a} when a < 3 -> "#{score_as_string(a)} equals"
      {a, a} -> "deuce"
      {a, b} when a < 4 and b < 4 -> "#{score_as_string(a)} #{score_as_string(b)}"
    end
  end

  def get_winner(game) do
    cond do
      check_player(game, :player1, :player2) -> :player1
      check_player(game, :player2, :player1) -> :player2
      true ->  :none
    end
  end
end
