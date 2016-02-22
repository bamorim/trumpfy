defmodule TrumpfyWeb.Card do
  use TrumpfyWeb.Web, :model

  schema "cards" do
    field :name, :string
    field :image_url, :string
    field :attribute1, :integer
    field :attribute2, :integer
    field :attribute3, :integer
    field :attribute4, :integer
    belongs_to :deck, TrumpfyWeb.Deck, foreign_key: :deck_id

    timestamps
  end

  @required_fields ~w(name image_url attribute1 attribute2 attribute3 attribute4 deck_id)
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

defimpl TrumpfyGame.Card, for: TrumpfyWeb.Card do
  def attribute_count(card), do: 4

  def attribute_value(card,1), do: card.attribute1
  def attribute_value(card,2), do: card.attribute2
  def attribute_value(card,3), do: card.attribute3
  def attribute_value(card,4), do: card.attribute4
end

defimpl Poison.Encoder, for: TrumpfyWeb.Card do
  def encode(card, options) do
    %{
      id: card.id,
      name: card.name,
      attribute1: card.attribute1,
      attribute2: card.attribute2,
      attribute3: card.attribute3,
      attribute4: card.attribute4,
      image_url: card.image_url
    } |> Poison.Encoder.encode(options)
  end
end
