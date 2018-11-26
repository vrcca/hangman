defmodule Hangman.Game do

  defstruct(
    turns_left: 7,
    state: :initializing,
    letters: [],
    used: MapSet.new()
  )
  
  def new_game() do
    new_game(Dictionary.random_word())
  end
  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints
    }
  end

  def make_move(game = %{state: state}, _guess) when state in [:won, :lost] do
    { game, tally(game) }
  end
  def make_move(game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.used, guess))
    { game, tally(game) }
  end

  def accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :state, :already_used)
  end
  def accept_move(game, guess, _already_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  def score_guess(game, _good_guess = true) do
    new_state = MapSet.new(game.letters)
    |> MapSet.subset?(game.used)
    |> maybe_won
    Map.put(game, :state, new_state)
  end
  def score_guess(game = %{ turns_left: 1 }, _not_good_guess) do
    %{ game |
       state: :lost,
       turns_left: 0
    }
  end
  def score_guess(game = %{ turns_left: turns_left }, _not_good_guess) do
    %{ game |
       state: :bad_guess,
       turns_left: turns_left - 1
    }
  end

  def tally(_game) do
    123
  end

  def maybe_won(true), do: :won
  def maybe_won(_), do: :good_guess
end
