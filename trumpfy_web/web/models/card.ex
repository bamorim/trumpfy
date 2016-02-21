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
