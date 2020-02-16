use Mix.Config

config :dog_registry, DogRegistry.Repo,
  username: "postgres",
  password: "postgres",
  database: "dog_registry_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :warn
