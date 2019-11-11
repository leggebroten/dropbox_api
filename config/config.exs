# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :dropbox_api,
  ecto_repos: [DropboxApi.Repo]

# Configures the endpoint
config :dropbox_api, DropboxApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "flfpUbhKgAzCPc6+x3htqCX1e0re4RSHFCTXxiGYSzJoD9lqJWV75jMaLJuw2Ymz",
  render_errors: [view: DropboxApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: DropboxApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :dropbox_api,
  auth_url: System.get_env("DROPBOX_AUTH_URL") || "https://www.dropbox.com/oauth2/authorize",
  token_url: System.get_env("DROPBOX_TOKEN_URL") || "https://api.dropbox.com/oauth2/token",
  app_key: System.get_env("DROPBOX_APP_KEY"),
  app_secret: System.get_env("DROPBOX_APP_SECRET"),
  redirect_url: System.get_env("DROPBOX_APP_REDIRECT"),
  authenticate_timeout: String.to_integer(System.get_env("DROPBOX_AUTHENTICATE_TIMEOUT") || "60000")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
