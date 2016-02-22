defprotocol TrumpfyGame.Deck do
  @doc "Return the cards of a deck"
  def cards(deck)
end

defimpl TrumpfyGame.Deck, for: List do
  def cards(deck), do: deck
end
