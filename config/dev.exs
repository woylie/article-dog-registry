use Mix.Config

config :dog_registry, DogRegistry.Repo,
  username: "postgres",
  password: "postgres",
  database: "dog_registry_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :logger, :console, format: "[$level] $message\n"
