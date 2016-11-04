defmodule DevChat.RoomController do
  use DevChat.Web, :controller

  alias DevChat.Room

  def index(conn, _params) do
    render conn, "index.html", rooms: DevChat.Repo.all(Room)
  end

  def show(conn, %{"id" => slug}) do
    user_token = conn.assigns[:user_token]

    render conn, "show.html", room: DevChat.Repo.one(from room in Room, where: room.slug == ^slug), user_token: user_token
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{}, :new)

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"room" => room_params}) do
    changeset = Room.changeset(%Room{}, :create, room_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Room created successfully.")
      |> redirect(to: room_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end
end
