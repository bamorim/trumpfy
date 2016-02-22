defmodule TrumpfyWeb.Deck do
  use TrumpfyWeb.Web, :model

  schema "decks" do
    field :name, :string
    field :attribute_name1, :string
    field :attribute_name2, :string
    field :attribute_name3, :string
    field :attribute_name4, :string

    has_many :cards, TrumpfyWeb.Card

    timestamps
  end

  @required_fields ~w(name attribute_name1 attribute_name2 attribute_name3 attribute_name4)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

defimpl TrumpfyGame.Deck, for: TrumpfyWeb.Deck do
  def cards(deck), do: deck.cards
end

defimpl Poison.Encoder, for: TrumpfyWeb.Deck do
  def encode(deck, options) do
    %{
      cards: deck.cards,
      name: deck.name,
      attribute_name1: deck.attribute_name1,
      attribute_name2: deck.attribute_name2,
      attribute_name3: deck.attribute_name3,
      attribute_name4: deck.attribute_name4
    }|> Poison.Encoder.encode(options)
  end
end
