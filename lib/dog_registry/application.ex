defmodule DogRegistry.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      DogRegistry.Repo
    ]

    opts = [strategy: :one_for_one, name: DogRegistry.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
