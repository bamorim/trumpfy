defmodule TrumpfyGame.Room do
  alias TrumpfyGame.Room

  defstruct id: nil, game: nil, curr: 0, deck: [], players: []

  # General API

  def create_room(deck, players) do
    room_id = Room.Listing.register
    room = %Room{deck: deck, players: players, id: room_id}
    {:ok, pid} = Room.Supervisor.create_room(room)
    {:ok, room_id, pid}
  end

  # Stateful actions

  def play(rid, players, attrs), do: call_server(rid, {:play, players, attrs})

  def get(rid), do: call_server(rid, :get)

  def add_player(rid, player), do: call_server(rid, {:add_player, player})

  def new_game(rid), do: call_server(rid, :new_game)

  # Room transformation

  def ready?(room), do: not pending?(room)

  def pending?(room), do: is_nil(room.game) || Game.finished?(room)

  def current_player(room), do: room.curr |> Enum.at(room.players)

  # Helpers

  defp call_server(room_id, msg) do
    pid = Room.Listing.get(room_id)
    if room_id do
      GenServer.call(pid, msg)
    else
      {:error, :room_not_found}
    end
  end
end
