defmodule TrumpfyWeb.Router do
  use TrumpfyWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :set_user_guid
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TrumpfyWeb do
    pipe_through :browser # Use the default browser stack

    get "/", DeckController, :index

    resources "/cards", CardController, only: [:index, :show, :edit, :update, :delete]
    resources "/decks", DeckController do
      resources "/cards", CardController, only: [:index, :create, :new]
    end

    resources "/rooms", RoomController, only: [:index, :show, :create]
  end

  def set_user_guid(conn, _) do
    guid = get_session(conn, :user_guid)
    put_session(conn, :user_guid, guid || Ecto.UUID.generate)
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrumpfyWeb do
  #   pipe_through :api
  # end
end
