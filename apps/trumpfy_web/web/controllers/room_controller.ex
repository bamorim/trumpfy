defmodule TrumpfyWeb.RoomController do
  use TrumpfyWeb.Web, :controller
  alias TrumpfyWeb.Deck

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"id" => room_id}) do
    room = TrumpfyGame.Room.get room_id

    render conn, "show.html", room: room
  end

  def create(conn, %{"room" => %{"deck_id" => deck_id}}) do
    deck = Repo.get!(Deck, deck_id) |> Repo.preload(:cards)

    {:ok, room_id, _pid} = TrumpfyGame.Room.create_room(deck, [])

    conn
    |> redirect(to: room_path(conn, :show, room_id))
  end
end
