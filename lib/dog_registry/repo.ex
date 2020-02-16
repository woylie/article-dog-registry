defmodule DogRegistry.Repo do
  use Ecto.Repo,
    otp_app: :dog_registry,
    adapter: Ecto.Adapters.Postgres
end
