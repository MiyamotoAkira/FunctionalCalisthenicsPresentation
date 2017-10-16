defmodule TennisTest do
  use ExUnit.Case
  #  doctest Tennis

  def assert_winner(actual_winner, expected_winner) do
    assert expected_winner == actual_winner
  end

  def assert_score(current_result, expected_result) do
    assert current_result == expected_result
  end

  test "Game setup" do
    game = Tennis.create_game()
    assert_score(game, %{player1: 0, player2: 0})
  end
  
  test "Game player1 scores once" do
    game = Tennis.create_game()
    game = Tennis.score(game, :player1)
    assert_score(game, %{player1: 1, player2: 0})
  end

  test "Game player 1 scores twice" do
    game = Tennis.create_game()
    game = Tennis.score(game, :player1)
    game = Tennis.score(game, :player1)
    assert_score(game, %{player1: 2, player2: 0})
  end
  
  test "Game only Player 1 scores and wins" do
    game = Tennis.create_game()
    game = Tennis.score(game, :player1)
    game = Tennis.score(game, :player1)
    game = Tennis.score(game, :player1)
    game = Tennis.score(game, :player1)
    winner = Tennis.get_winner(game)
    assert_winner(winner, :player1)
  end
end
