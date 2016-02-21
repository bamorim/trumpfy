defmodule TrumpfyWeb.RoomController do
  use TrumpfyWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"id" => room_id}) do
    room = TrumpfyGame.Room.get room_id

    render conn, "show.html", room: room
  end

  def create(conn, %{"room" => %{"deck_id" => deck_id}}) do
    card_query = from c in TrumpfyWeb.Card,
                 where: c.deck_id == ^deck_id

    cards = Repo.all(card_query)

    {:ok, room_id, _pid} = TrumpfyGame.Room.create_room(cards, [])

    conn
    |> redirect(to: room_path(conn, :show, room_id))
  end
end
