defmodule GallowsWeb.HangmanController do
  use GallowsWeb, :controller

  def create_game(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    conn
    |> put_session(:game, game)
    |> assign(:tally, tally)
    |> render("game_field.html")
  end

  def make_move(conn, %{"make_move" => %{"guess" => guess}}) do
    tally =
      conn
      |> get_session(:game)
      |> Hangman.make_move(guess)

    put_in(conn.params["make_move"]["guess"], "")
    |> assign(:tally, tally)
    |> render("game_field.html")
  end
end
