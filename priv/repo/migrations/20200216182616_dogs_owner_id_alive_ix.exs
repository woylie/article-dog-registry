defmodule DogRegistry.Repo.Migrations.DogsOwnerIdAliveIx do
  use Ecto.Migration

  def change do
    create unique_index(:dogs, [:owner_id, :status],
             name: "dogs_owner_id_alive_ix",
             where: "status = 'alive'"
           )
  end
end
