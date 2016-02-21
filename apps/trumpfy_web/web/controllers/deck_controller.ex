defmodule TrumpfyWeb.DeckController do
  use TrumpfyWeb.Web, :controller

  alias TrumpfyWeb.Deck

  plug :scrub_params, "deck" when action in [:create, :update]

  def index(conn, _params) do
    decks = Repo.all(Deck)
    render(conn, "index.html", decks: decks)
  end

  def new(conn, _params) do
    changeset = Deck.changeset(%Deck{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"deck" => deck_params}) do
    changeset = Deck.changeset(%Deck{}, deck_params)

    case Repo.insert(changeset) do
      {:ok, _deck} ->
        conn
        |> put_flash(:info, "Deck created successfully.")
        |> redirect(to: deck_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    deck = Repo.get!(Deck, id)
    render(conn, "show.html", deck: deck)
  end

  def edit(conn, %{"id" => id}) do
    deck = Repo.get!(Deck, id)
    changeset = Deck.changeset(deck)
    render(conn, "edit.html", deck: deck, changeset: changeset)
  end

  def update(conn, %{"id" => id, "deck" => deck_params}) do
    deck = Repo.get!(Deck, id)
    changeset = Deck.changeset(deck, deck_params)

    case Repo.update(changeset) do
      {:ok, deck} ->
        conn
        |> put_flash(:info, "Deck updated successfully.")
        |> redirect(to: deck_path(conn, :show, deck))
      {:error, changeset} ->
        render(conn, "edit.html", deck: deck, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    deck = Repo.get!(Deck, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(deck)

    conn
    |> put_flash(:info, "Deck deleted successfully.")
    |> redirect(to: deck_path(conn, :index))
  end
end
