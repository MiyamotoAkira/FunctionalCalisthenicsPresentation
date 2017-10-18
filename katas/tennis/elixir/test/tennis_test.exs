defmodule TennisTest do
  use ExUnit.Case
  use ExUnit.Parameterized
  use Quixir

  def assert_winner(actual_winner, expected_winner) do
    assert expected_winner == actual_winner
  end

  def assert_score(current_result, expected_result) do
    assert current_result == expected_result
  end

  def assert_report_score(current_report, expected_report) do
    assert current_report == expected_report
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

  test "Game went to multiple deuce and Player1 won" do
    Tennis.create_game(7, 5)
    |> Tennis.get_winner()
    |> assert_winner(:player1)
  end

  test "Game went to multiple deuce and Player2 won" do
    Tennis.create_game(5, 7)
    |> Tennis.get_winner()
    |> assert_winner(:player2)
  end

  test "Game with player on 4 and other below has a winner" do
    ptest score: int(max: 3) do
      Tennis.create_game(4, score)
      |> Tennis.get_winner()
      |> assert_winner(:player1)
    end

    ptest score: int(max: 3) do
      Tennis.create_game(score, 4)
      |> Tennis.get_winner()
      |> assert_winner(:player2)
    end
end

  test "Game no player with 4 points doesn't have a winner" do
    ptest p1_score: int(max: 3), p2_score: int(max: 3) do
      Tennis.create_game(p1_score, p2_score)
      |> Tennis.get_winner()
      |> assert_winner(:none)
    end
  end

  test "Game with both players same score doesn't have a winner" do
    ptest score: int() do
      Tennis.create_game(score, score)
      |> Tennis.get_winner()
      |> assert_winner(:none)
    end
  end

  test "Game with one player in winning range but not 2 clear" do
    ptest score: int(min: 5) do
      Tennis.create_game(score, score - 1)
      |> Tennis.get_winner()
      |> assert_winner(:none)
    end

    ptest score: int(min: 5) do
      Tennis.create_game(score - 1, score)
      |> Tennis.get_winner()
      |> assert_winner(:none)
    end
  end

  test "Game with one player in winning range" do
    ptest score: int(min: 5) do
      Tennis.create_game(score, score - 2)
      |> Tennis.get_winner()
      |> assert_winner(:player1)
    end

    ptest score: int(min: 5) do
      Tennis.create_game(score - 2, score)
      |> Tennis.get_winner()
      |> assert_winner(:player2)
    end
  end

  test_with_params "report score",
  fn (p1_score, p2_score, expected_report) ->
    Tennis.create_game(p1_score, p2_score)
    |> Tennis.report_score()
    |> assert_report_score(expected_report)
  end do
    [
      {0, 0, "love all"},
      {1, 0, "fifteen love"},
      {0, 1, "love fifteen"},
      {2, 3, "thirty forty"},
      {2, 2, "thirty equals"},
      {3, 3, "deuce"},
      {4, 4, "deuce"},
      {4, 3, "advantage player 1"},
      {4, 5, "advantage player 2"},
      {4, 6, "game finished"}
    ]
  end
end
