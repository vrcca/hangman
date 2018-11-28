defmodule TextClient.Player do

  alias TextClient.State

  # TODO: good guess
  # TODO: bad guess
  # TODO: already used
  # TODO: initialising
  def play(%State{tally: %{ state: :won }}) do
    exit_with_message("You WON!")
  end
  def play(%State{tally: %{ state: :lost }}) do
    exit_with_message("Sorry, you lost.")
  end
  def play(game = %State{tally: %{ state: :good_guess }}) do
    continue_with_message(game, "Good guess!")
  end
  def play(game = %State{tally: %{ state: :bad_guess }}) do
    continue_with_message(game, "Sorry, that isn't in the word")
  end
  def play(game = %State{tally: %{ state: :already_used }}) do
    continue_with_message(game, "You've already used that letter")
  end
  def play(game) do
    continue(game)
  end

  defp continue(game) do
    game
    |> display()
    |> prompt()
    |> make_move()
    |> play()
  end

  defp display(game) do
    game
  end

  defp prompt(game) do
    game
  end

  defp make_move(game) do
    game
  end

  defp continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end
  
  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
  
end
