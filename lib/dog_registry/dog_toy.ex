defmodule DogRegistry.DogToy do
  use Ecto.Schema

  import Ecto.Changeset

  alias DogRegistry.Dog

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "dog_toys" do
    field :product, :string
    field :rating, :integer

    belongs_to :dog, Dog

    timestamps()
  end

  def changeset(dog, attrs) do
    dog
    |> cast(attrs, [:product, :rating])
    |> validate_required([:product, :rating])
    |> foreign_key_constraint(:dog_id)
  end
end
