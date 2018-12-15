defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import GallowsWeb.Views.Helpers.GameStateHelper

  def new_game_button(conn) do
    button("New Game", to: Routes.hangman_path(conn, :create_game))
  end

  def word_so_far(letters) do
    letters |> Enum.join(" ")
  end

  def used_so_far([]), do: "None"
  def used_so_far(letters), do: letters |> Enum.join(" ")

  def game_over?(%{state: state}) do
    state in [:won, :lost]
  end

  def turn(left, target) when target >= left do
    "dim"
    |> raw()
  end

  def turn(_left, _target) do
    "faint"
    |> raw()
  end
end
