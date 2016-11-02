defmodule DevChat.Router do
  use DevChat.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DevChat do
    pipe_through :browser # Use the default browser stack

    get "/", RoomController, :index

    resources "/rooms", RoomController, except: [:index, :edit, :update, :destroy]
  end

  # Other scopes may use custom stacks.
  # scope "/api", DevChat do
  #   pipe_through :api
  # end
end
