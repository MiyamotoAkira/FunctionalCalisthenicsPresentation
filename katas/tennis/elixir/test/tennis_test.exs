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
    Tennis.create_game()
    |> assert_score(%{player1: 0, player2: 0})
  end

  test "Game setup with score" do
    Tennis.create_game(3,4)
    |> assert_score(%{player1: 3, player2: 4})
  end

  test "Game player1 scores once" do
    Tennis.create_game()
    |> Tennis.score(:player1)
    |> assert_score(%{player1: 1, player2: 0})
  end

  test "Game player2 scores once" do
    Tennis.create_game()
    |> Tennis.score(:player2)
    |> assert_score(%{player1: 0, player2: 1})
  end

  test "Game player 1 scores twice" do
    Tennis.create_game()
    |> Tennis.score(:player1)
    |> Tennis.score(:player1)
    |> assert_score(%{player1: 2, player2: 0})
  end
  
  test "Game only Player 1 scores and wins" do
    Tennis.create_game()
    |> Tennis.score(:player1)
    |> Tennis.score(:player1)
    |> Tennis.score(:player1)
    |> Tennis.score(:player1)
    |> Tennis.get_winner()
    |> assert_winner(:player1)
  end

  test "Game only Player 2 scores and wins" do
    Tennis.create_game()
    |> Tennis.score(:player2)
    |> Tennis.score(:player2)
    |> Tennis.score(:player2)
    |> Tennis.score(:player2)
    |> Tennis.get_winner()
    |> assert_winner(:player2)
  end

  test "Game went to deuce and Player1 won" do
    Tennis.create_game()
    |> Tennis.score(:player2)
    |> Tennis.score(:player2)
    |> Tennis.score(:player2)
    |> Tennis.score(:player1)
    |> Tennis.score(:player1)
    |> Tennis.score(:player1)
    |> Tennis.score(:player1)
    |> Tennis.score(:player1)
    |> Tennis.get_winner()
    |> assert_winner(:player1)
  end

  test "Game went to deuce and Player2 won" do
    Tennis.create_game()
    |> Tennis.score(:player2)
    |> Tennis.score(:player2)
    |> Tennis.score(:player2)
    |> Tennis.score(:player1)
    |> Tennis.score(:player1)
    |> Tennis.score(:player1)
    |> Tennis.score(:player2)
    |> Tennis.score(:player2)
    |> Tennis.get_winner()
    |> assert_winner(:player2)
  end

end
