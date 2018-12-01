defmodule Hangman.Server do

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    { :ok, Hangman.new_game() }
  end

  def handle_call({ :make_move, guess }, _from, state_game) do
    { game, tally } = Hangman.make_move(state_game, guess)
    { :reply, tally, game }
  end

end
