defmodule DevChat.Plugs.SetUserToken do
  import Plug.Conn

  @behavior Plug

  def init(default) do
    default
  end

  def call(conn, config) do
    fetch_session(conn)
    |> set_user_token
  end

  defp set_user_token(conn = %Plug.Conn{private: %{plug_session: %{"user_token" => user_token}}}) do
    conn
    |> assign(:user_token, user_token)
  end

  defp set_user_token(conn) do
    user_token = generate_user_token

    conn
    |> put_session(:user_token, user_token)
    |> assign(:user_token, user_token)
  end

  defp generate_user_token do
    :crypto.hash(:sha256, (DateTime.utc_now |> DateTime.to_iso8601) <> (:rand.uniform |> to_string))
    |> Base.encode16
    |> String.downcase
  end
end
