defmodule TrumpfyWeb.RoomController do
  use TrumpfyWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, _params) do
    render conn, "show.html"
  end

  def create(conn, %{"deck_id" => deck_id}) do
    deck = TrumpfyGame.Helpers.create_random_cards(4,40)
    {:ok, room_id, _pid} = TrumpfyGame.Room.create_game(deck)
    conn
    |> redirect(to: room_path(conn, :show, room_id))
  end
end
