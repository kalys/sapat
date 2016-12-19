# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sapat,
  ecto_repos: [Sapat.Repo]

# Configures the endpoint
config :sapat, Sapat.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HBVsXEdYIbiEOM9wPF+6DR+FZ9shv7XTooe3VvT/68+AzxArWKtCDvn1kZ1cXMbg",
  render_errors: [view: Sapat.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sapat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :arc,
  storage: Arc.Storage.S3
