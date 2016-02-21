defmodule TrumpfyGame.Room.Server do
  use GenServer

  alias TrumpfyGame.{Game, Room}

  # Supervisor API

  def start_link(state, opts \\ []) do
    GenServer.start_link(__MODULE__, state, opts)
  end

  # GenServer API

  def init(room) do
    game = Game.new(room.deck, length(room.players))
    Room.Listing.set(room.id, self)

    room = %Room{room | game: game}
    {:ok, room}
  end

  def handle_call({:play, player, attribute}, _from, state) when is_integer(attribute) do
    if Enum.at(state.players, state.curr) != player do
      {:reply, {:error, :not_this_player_turn}, state}
    else
      handle_play(attribute, state)
    end
  end
  def handle_call(:hands, _from, state), do: {:reply, get_hands(state), state}
  def handle_call(:current_player, _from, state), do: {:reply, Enum.at(state.players,state.curr), state}

  defp get_hands(state) do
    state.players |> Enum.zip(state.game) |> Enum.into(%{})
  end

  defp handle_play(attribute, state) do
    {newGame, winner_id} = state.game
    |> Game.play(attribute)

    won_cards = state.game
      |> Stream.with_index
      |> Enum.map( fn {x,i} -> {state.players |> Enum.at(i), List.first(x)} end )
      |> Enum.into(%{})

    winner = state.players |> Enum.at(winner_id)

    reply = {winner, won_cards}
    newState = %Room{ state | game: newGame, curr: winner_id }

    if Game.finished(newGame) do
      {:stop, :normal, {:ok, :game_finished}, newState}
    else
      {:reply, {:ok, reply}, newState}
    end
  end
end
