defmodule TrumpfyGame.GameServer do
  @moduledoc """
  This application supervises and manages all the room servers
  """

  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      # Don't know what restart: :transient does
      # Just copying from the docs
      worker(TrumpfyGame.RoomServer, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

  @doc """
  Create a new game and returns a pid
  """
  def create_game(deck, players) do
    Supervisor.start_child(__MODULE__, [{deck, players},[]])
  end
end
