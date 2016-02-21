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

  def play(rid, players, attrs), do: call_room(rid, {:play, players, attrs})

  # Room transformation

  def hands(rid), do: call_room(rid, :hands)

  def current_player(rid), do: call_room(rid, :current_player)

  defp call_room(room_id, msg) do
    pid = Room.Listing.get(room_id)
    if room_id do
      GenServer.call(pid, msg)
    else
      {:error, :room_not_found}
    end
  end
end
