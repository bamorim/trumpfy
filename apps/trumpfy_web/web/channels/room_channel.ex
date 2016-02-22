defmodule TrumpfyWeb.RoomChannel do

  defmodule Player do
    defstruct id: "", name: "", socket_ref: nil
  end
  defimpl Poison.Encoder, for: Player do
    def encode(player, options), do: player.name |> Poison.Encoder.encode(options)
  end
  defimpl TrumpfyGame.Player, for: Player do
    def is?(p1,p2), do: p1.id == p2.id
  end

  use Phoenix.Channel

  require Logger

  def join("rooms:" <> room_id, message, socket) do
    socket = Phoenix.Socket.assign(socket, :room_id, room_id)
    {:ok, socket}
  end

  def handle_in("setup",%{ "room_id" => room_id, "name" => name },socket) do
    user_guid = socket.assigns.user_guid
    player = %Player{ name: name, id: user_guid, socket_ref: socket }

    {:ok, players} = TrumpfyGame.Room.add_player room_id , player

    players |> Enum.each( &( send_status(&1.socket_ref, room_id, &1) ) )

    {:noreply, socket}
  end
  def handle_in("action:new_game",%{"room_id" => room_id},socket) do
    TrumpfyGame.Room.new_game(room_id)
    send_status_to_all(room_id)
    {:noreply, socket}
  end
  def handle_in("action:play",%{"room_id" => room_id, "attribute" => attr},socket) do
    player = %Player{id: socket.assigns.user_guid}

    case TrumpfyGame.Room.play(room_id, player, attr) do
      {:ok, _}
        -> send_status_to_all(room_id)
      _ 
        -> :invalid
    end

    {:noreply, socket}
  end

  def send_status_to_all(room_id) do
    room = TrumpfyGame.Room.get room_id

    IO.puts("sending status to all")
    room.players |> Enum.each( &( send_status(&1.socket_ref, room, &1) ) )
  end

  def send_status(socket, room_id, player) when is_binary(room_id) do
    send_status(socket, room_id |> TrumpfyGame.Room.get, player)
  end
  def send_status(socket, room, player) do
    room_status = room
    |> TrumpfyGame.Room.scoped_info(player)

    push socket, "update:state", room_status
  end
end
