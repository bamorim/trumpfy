defmodule TrumpfyGame.Room.Listing do
  def start_link do
    Agent.start_link(fn -> HashDict.new end, name: __MODULE__)
  end

  def register do
    key = random_key(6)
    if(get(key)) do
      # Key already found
      register
    else
      set(key, :pending)
      key
    end
  end

  def set(room_id, pid) do
    Agent.update(__MODULE__, &(HashDict.put(&1, room_id, pid)))
  end


  def get(room_id) do
    Agent.get(__MODULE__, &(HashDict.get(&1, room_id)))
  end

  def random_key(size) do
    (1..size)
    |> Enum.map(fn _x ->
      (69..90) |> Enum.shuffle |> List.first
    end) |> List.to_string
  end
end
