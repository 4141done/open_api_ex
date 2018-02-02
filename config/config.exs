# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :open_api_fun,
  ecto_repos: [OpenApiFun.Repo]

# Configures the endpoint
config :open_api_fun, OpenApiFunWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/9OBwsM+TTwfo/vArhYjE4ztgNrVtvqRrhs4Tvgjg7pfy/qJMsSbx3YSO8rrMntk",
  render_errors: [view: OpenApiFunWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: OpenApiFun.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
