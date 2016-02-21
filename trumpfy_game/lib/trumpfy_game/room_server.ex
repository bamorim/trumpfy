defmodule TrumpfyGame.RoomServer do
  @moduledoc """
  The room game server holds the total state of the game, such as
  the currently playing player, an external player identification
  and also the game itself
  """

  use GenServer

  alias TrumpfyGame.Game

  # Public API

  def start(deck, players) do
    GenServer.start(__MODULE__, {deck, players})
  end

  def start_link(state, opts \\ []) do
    GenServer.start_link(__MODULE__, state, opts)
  end

  def play(pid, player, attribute) do
    GenServer.call(pid, {:play, player, attribute})
  end

  def hands(pid) do
    GenServer.call(pid, :hands)
  end

  def current_player(pid) do
    GenServer.call(pid, :current_player)
  end

  # GenServer API

  def init({deck, players}) do
    game = Game.new(deck, length(players))
    {:ok, {players, game, 0}}
  end

  def handle_call({:play, player, attribute}, _from, state={players, _game, curr}) do
    if Enum.at(players, curr) != player do
      {:reply, {:error, :not_this_player_turn}, state}
    else
      handle_play(attribute, state)
    end
  end
  def handle_call(:hands, _from, state), do: {:reply, get_hands(state), state}
  def handle_call(:current_player, _fron, state={players,_game,curr}), do: {:reply, Enum.at(players,curr), state}

  defp get_hands({players, game, _curr}) do
    players |> Enum.zip(game) |> Enum.into(%{})
  end

  defp handle_play(attribute, {players, game, _curr}) do
    {newGame, winner_id} = game
    |> Game.play(attribute)

    won_cards = game
      |> Stream.with_index
      |> Enum.map( fn {x,i} -> {players |> Enum.at(i), List.first(x)} end )
      |> Enum.into(%{})

    winner = players |> Enum.at(winner_id)

    reply = {winner, won_cards}
    newState = {players, newGame, winner_id}

    if Game.finished(newGame) do
      {:stop, :normal, {:ok, :game_finished}, newState}
    else
      {:reply, {:ok, reply}, newState}
    end
  end
end
