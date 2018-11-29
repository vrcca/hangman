defmodule TextClient.Summary do
  def display(game = %{ tally: tally }) do
    IO.puts [
      "\n",
      "Word so far: #{Enum.join(tally.letters.guessed, " ")}\n",
      "Guesses left: #{tally.turns_left}\n",
      "#{display_already_used(tally.letters.used)}\n"
    ]
    game
  end

  defp display_already_used([]) do
    "No letters tried so far."
  end
  defp display_already_used(used_letters) do
    "Already used: #{Enum.join(used_letters, " ")}"
  end
end
