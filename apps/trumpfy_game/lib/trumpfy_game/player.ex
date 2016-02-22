defprotocol TrumpfyGame.Player do
  @doc "Compares two players to see if the first is the same as the second"
  def is?(player_a, player_b)
end
