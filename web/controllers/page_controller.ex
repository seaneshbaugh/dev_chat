defmodule DevChat.PageController do
  use DevChat.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
