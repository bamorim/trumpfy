defprotocol TrumpfyGame.Card do
  @doc "Return the ammount of attributes it contains"
  def attribute_count(card)

  @doc "Return the value of a given attribute"
  def attribute_value(card,attr)
end

defmodule TrumpfyGame.BasicCard do
  @moduledoc """
  A card is a list of attributes and an external identifier
  """
  defstruct attributes: []
end

defimpl TrumpfyGame.Card, for: TrumpfyGame.BasicCard do
  def attribute_count(card) do
    length(card.attributes)
  end

  def attribute_value(card, attribute) do
    card.attributes |> Enum.at(attribute)
  end
end
