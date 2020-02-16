use Mix.Config

config :dog_registry,
  ecto_repos: [DogRegistry.Repo],
  generators: [binary_id: true]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env()}.exs"
