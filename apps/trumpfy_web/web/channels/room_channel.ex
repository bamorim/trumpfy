defmodule TrumpfyWeb.RoomChannel do
  use Phoenix.Channel
  require Logger

  def join("rooms:" <> room_id, message, socket) do
    Logger.debug(inspect(socket))
    Logger.debug(socket.assigns.user_guid)
    Logger.debug(room_id)
    {:ok, socket}
  end
end
