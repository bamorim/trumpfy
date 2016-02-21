defmodule TrumpfyWeb.RoomController do
  use TrumpfyWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, _params) do
    render conn, "show.html"
  end

  def create(conn, %{"deck_id" => deck_id}) do
    card_query = from c in TrumpfyWeb.Card,
                 where: c.deck_id == ^deck_id

    cards = Repo.all(card_query)
    {:ok, room_id, _pid} = TrumpfyGame.Room.create_game()
    conn
    |> redirect(to: room_path(conn, :show, room_id))
  end
end
