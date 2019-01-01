defmodule SocketGallowsWeb.HangmanChannel do

  require Logger
  use Phoenix.Channel

  def join("hangman:game", _params, socket) do
    socket = socket |> assign(:game, Hangman.new_game())
    {:ok, socket}
  end

  def handle_in("tally", _params, socket) do
    game = socket.assigns.game
    tally = Hangman.tally(game)
    push(socket, "tally", tally)
    {:noreply, socket}
  end

  def handle_in("make_move", guess, socket) do
    tally = socket.assigns.game |> Hangman.make_move(guess)
    push(socket, "tally", tally)
    {:noreply, socket}
  end

  def handle_in("new_game", _, socket) do
    socket = socket |> assign(:game, Hangman.new_game())
    handle_in("tally", nil, socket)
  end

  def handle_in(unknown_request, params, socket) do
    Logger.error("An unknown request named '#{unknown_request}'" <> 
      " was made to Hangman Channel with the following params: " <> inspect(params))
    {:noreply, socket}
  end
  
end
