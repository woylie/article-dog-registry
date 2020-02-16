defmodule DogRegistry.Owner do
  use Ecto.Schema

  import Ecto.Changeset

  alias DogRegistry.Dog

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "owners" do
    field :name, :string
    field :city, :string

    has_one :dog, Dog

    timestamps()
  end

  def changeset(dog, attrs) do
    dog
    |> cast(attrs, [:name, :city])
    |> validate_required([:name])
  end
end
