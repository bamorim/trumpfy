defmodule TrumpfyWeb.PageController do
  use TrumpfyWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
