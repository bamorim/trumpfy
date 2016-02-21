defmodule TrumpfyGame.Room.Server do
  use GenServer

  alias TrumpfyGame.{Game, Room}

  # Supervisor API

  def start_link(room, opts \\ []) do
    GenServer.start_link(__MODULE__, room, opts)
  end

  # GenServer API

  def init(room) do
    Room.Listing.set(room.id, self)
    {:ok, room}
  end

  def handle_call({:play, player, attribute}, _from, room) when is_integer(attribute) do
    cond do
      Room.pending?(room) ->
        {:reply, {:error, :game_not_ready}, room}
      Enum.at(room.players, room.curr) != player ->
        {:reply, {:error, :not_this_player_turn}, room}
      true ->
        do_play(attribute, room)
    end
  end
  def handle_call(:get, _from, room), do: room
  def handle_call(:new_game, _from, room) do
    if Room.pending?(room) do
      nplayers = length(room.players)
      game = Game.new(room.deck, nplayers)
      curr = :rand.uniform(nplayers) - 1
      room = %Room{room | game: game, curr: curr}
      {:reply, {:ok, room}, room}
    else
      {:reply, {:error, :game_currently_running}, room}
    end
  end
  def handle_call({:add_player, player}, _from, room) do
    room = %Room{room | players: room.players ++ [player]}
    {:reply, {:ok, room.players}, room}
  end
  def handle_call({:remove_player, player}, _from, room) do
    {:reply, {:error, :not_implemented_yet}, room}
  end

  defp do_play(attribute, room) do
    {newGame, winner_id} = room.game
    |> Game.play(attribute)

    won_cards = room.game
      |> Stream.with_index
      |> Enum.map( fn {x,i} -> {room.players |> Enum.at(i), List.first(x)} end )
      |> Enum.into(%{})

    winner = room.players |> Enum.at(winner_id)

    reply = {winner, won_cards}
    newState = %Room{ room | game: newGame, curr: winner_id }

    {:reply, {:ok, reply}, newState}
  end
end
