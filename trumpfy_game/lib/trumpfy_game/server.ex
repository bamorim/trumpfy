defmodule TrumpfyGame.Server do
  @moduledoc """
  The game server holds the total state of the game, such as
  the currently playing player, an external player identification
  and also the game itself
  """

  use GenServer

  alias TrumpfyGame.Game

  # Public API

  def start(players, deck) do
    game = Game.new(deck, length(players))
    GenServer.start(__MODULE__, {players, game, 0})
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

  def handle_call({:play, player, attribute}, _from, state={players, game, curr}) do
    if Enum.at(players, curr) != player do
      {:reply, {:error, :not_this_player_turn}, state}
    else
      if Game.finished(game) do
        {:reply, {:error, :game_already_finished}, state}
      else
        handle_play(attribute, state)
      end
    end
  end
  def handle_call(:hands, _from, state), do: {:reply, get_hands(state), state}
  def handle_call(:current_player, _fron, state={players,_game,curr}), do: {:reply, Enum.at(players,curr), state}

  defp get_hands({players, game, _curr}) do
    players |> Enum.zip(game) |> Enum.into(%{})
  end

  defp handle_play(attribute, state={players, game, curr}) do
    {newGame, winner_id} = game
    |> Game.play(attribute)

    won_cards = game
      |> Stream.with_index
      |> Enum.map( fn {x,i} -> {players |> Enum.at(i), List.first(x)} end )
      |> Enum.into(%{})

    winner = players |> Enum.at(winner_id)

    reply = {winner, won_cards}
    newState = {players, newGame, winner_id}

    {:reply, {:ok, reply}, newState}
  end
end
