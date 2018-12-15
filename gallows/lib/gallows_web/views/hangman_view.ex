defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import GallowsWeb.Views.Helpers.GameStateHelper

  def new_game_button(conn) do
    button("New Game", to: Routes.hangman_path(conn, :create_game))
  end

  def word_so_far(tally) do
    tally.letters.guessed |> Enum.join(" ")
  end

  def game_over?(%{state: state}) do
    state in [:won, :lost]
  end
end
