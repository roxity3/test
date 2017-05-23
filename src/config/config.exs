# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ewms,
  ecto_repos: [Ewms.Repo]

# Configures the endpoint
config :ewms, Ewms.Endpoint,
  http: [port: 4000],
  url: [host: "localhost"],
  render_errors: [view: Ewms.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ewms.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: true


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
