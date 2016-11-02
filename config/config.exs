# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dev_chat,
  ecto_repos: [DevChat.Repo]

# Configures the endpoint
config :dev_chat, DevChat.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D8dIXE5wB3f3xcAw0j12+dk70XQeIL2S3nHsIOsp2J1KENWlwhJAi2Ny8MGRBUtL",
  render_errors: [view: DevChat.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DevChat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
