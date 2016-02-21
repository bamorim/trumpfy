defmodule TrumpfyWeb.DeckTest do
  use TrumpfyWeb.ModelCase

  alias TrumpfyWeb.Deck

  @valid_attrs %{attribute_name1: "some content", attribute_name2: "some content", attribute_name3: "some content", attribute_name4: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Deck.changeset(%Deck{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Deck.changeset(%Deck{}, @invalid_attrs)
    refute changeset.valid?
  end
end
