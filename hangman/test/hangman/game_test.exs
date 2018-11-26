defmodule Hangman.GameTest do
  use ExUnit.Case
  doctest Hangman.Game
  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.state == :initializing
    assert length(game.letters) > 0
    assert Enum.all?(game.letters, &(String.match?(&1, ~r/[a-z]/)))
  end

  test "state isn't changed for :won or :lost games" do
    for state <- [ :won, :lost ] do
      game = Game.new_game() |> Map.put(:state, state)
      assert { ^game, _ } = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "x")
    assert game.state != :already_used
  end

  test "second occurrence of letter is not already used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "x")
    assert game.state != :already_used
    { game, _tally } = Game.make_move(game, "x")
    assert game.state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    { game, _tally } = Game.make_move(game, "w")
    assert game.state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("won")
    
    { game, _tally } = Game.make_move(game, "w")
    assert game.state == :good_guess
    assert game.turns_left == 7
    { game, _tally } = Game.make_move(game, "o")
    assert game.state == :good_guess
    assert game.turns_left == 7
    { game, _tally } = Game.make_move(game, "n")
    assert game.state == :won
    assert game.turns_left == 7
  end

  test "bad guess is recognized" do
    game = Game.new_game("wit")
    { game, _tally } = Game.make_move(game, "x")
    assert game.state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do
    moves = [
      {"x", :bad_guess, 6},
      {"y", :bad_guess, 5},
      {"a", :bad_guess, 4},
      {"b", :bad_guess, 3},
      {"c", :bad_guess, 2},
      {"d", :bad_guess, 1},
      {"e", :lost, 0},
    ]

    assert_moves = fn ({ letter, state, turns }, game) ->
      { game, _tally } = Game.make_move(game, letter)
      assert game.state == state
      assert game.turns_left == turns
      game
    end
    
    Enum.reduce(moves, Game.new_game("wit"), assert_moves)
  end
end
