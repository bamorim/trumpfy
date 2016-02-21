defmodule TrumpfyWeb.CardTest do
  use TrumpfyWeb.ModelCase

  alias TrumpfyWeb.Card

  @valid_attrs %{attribute1: "some content", attribute2: "some content", attribute3: "some content", attribute4: "some content", image_url: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Card.changeset(%Card{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Card.changeset(%Card{}, @invalid_attrs)
    refute changeset.valid?
  end
end
