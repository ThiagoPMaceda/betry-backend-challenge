# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :betrybebackendchallenge,
  ecto_repos: [Betrybebackendchallenge.Repo]

# Configures the endpoint
config :betrybebackendchallenge, BetrybebackendchallengeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QIQErTU4MovLtVpm3tC+Tar4n/kQvPtnNnpu5uvYAmLydCs8TD84KnCQbFlhq43c",
  render_errors: [view: BetrybebackendchallengeWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Betrybebackendchallenge.PubSub,
  live_view: [signing_salt: "uUg2DCj5"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :betrybebackendchallenge, BetrybebackendchallengeWeb.Guardian,
  issuer: "betrybebackendchallenge",
  secret_key: "o+qndi+aziNao9U3wbj2l3HLm+a8Qnffkkwjf63UC45VvmZpKExe9EdQKf10hiiR"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
