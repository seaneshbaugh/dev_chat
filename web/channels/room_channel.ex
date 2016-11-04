defmodule DevChat.RoomChannel do
  use DevChat.Web, :channel

  def join("rooms:" <> room_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", params, socket) do
    broadcast! socket, "new_message", %{
      body: params["body"],
      at: DateTime.utc_now |> DateTime.to_iso8601,
      user_token: socket.assigns[:user_token]
    }

    {:reply, :ok, socket}
  end

  def handle_info(:ping, socket) do
    count = socket.assigns[:count] || 1

    push socket, "ping", %{count: count}

    {:noreply, assign(socket, :count, count + 1)}
  end
end
