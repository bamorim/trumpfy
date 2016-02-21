defmodule TrumpfyWeb.CardController do
  use TrumpfyWeb.Web, :controller

  alias TrumpfyWeb.{Card, Deck}

  plug :scrub_params, "card" when action in [:create, :update]

  def index(conn, %{"deck_id" => deck_id}) do
    deck = Repo.get!(Deck, deck_id)
    query = from c in Card, where: c.deck_id == ^deck_id
    cards = Repo.all(query)
    render(conn, "index.html", cards: cards, deck: deck)
  end

  def new(conn, %{"deck_id" => deck_id}) do
    changeset = Card.changeset(%Card{deck_id: deck_id})
    render(conn, "new.html", changeset: changeset, deck_id: deck_id)
  end

  def create(conn, %{"card" => card_params, "deck_id" => deck_id}) do
    changeset = Card.changeset(%Card{deck_id: deck_id}, card_params)

    case Repo.insert(changeset) do
      {:ok, _card} ->
        conn
        |> put_flash(:info, "Card created successfully.")
        |> redirect(to: deck_card_path(conn, :index, deck_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, deck_id: deck_id)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Repo.get!(Card, id)
    render(conn, "show.html", card: card)
  end

  def edit(conn, %{"id" => id}) do
    card = Repo.get!(Card, id)
    changeset = Card.changeset(card)
    render(conn, "edit.html", card: card, changeset: changeset)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Repo.get!(Card, id)
    changeset = Card.changeset(card, card_params)

    case Repo.update(changeset) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card updated successfully.")
        |> redirect(to: card_path(conn, :show, card))
      {:error, changeset} ->
        render(conn, "edit.html", card: card, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "deck_id" => deck_id}) do
    card = Repo.get!(Card, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(card)

    conn
    |> put_flash(:info, "Card deleted successfully.")
    |> redirect(to: deck_card_path(conn, deck_id, :index))
  end
end
