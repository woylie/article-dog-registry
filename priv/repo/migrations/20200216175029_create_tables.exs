defmodule DogRegistry.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:owners, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :city, :string, null: false

      timestamps()
    end

    create table(:dogs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :status, :string, null: false

      add :owner_id, references(:owners, on_delete: :nilify_all, type: :uuid)

      timestamps()
    end

    create table(:dog_toys, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :product, :string
      add :rating, :integer

      add :dog_id, references(:dogs, on_delete: :nilify_all, type: :uuid)

      timestamps()
    end

    create index(:dog_toys, :dog_id)
  end
end
