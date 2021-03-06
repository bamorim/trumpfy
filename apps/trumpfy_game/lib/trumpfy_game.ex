defmodule TrumpfyGame do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(TrumpfyGame.Room.Supervisor, []),
      worker(TrumpfyGame.Room.Listing, [])
    ]

    opts = [strategy: :one_for_one, name: TrumpfyGame.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
