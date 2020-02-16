defmodule DogRegistry.Dog do
  use Ecto.Schema

  import Ecto.Changeset

  alias DogRegistry.DogToy
  alias DogRegistry.Owner
  alias DogRegistry.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "dogs" do
    field :name, :string
    field :status, :string

    belongs_to :owner, Owner
    has_many :toys, DogToy

    timestamps()
  end

  def changeset(dog, attrs) do
    dog
    |> cast(attrs, [:name, :owner_id, :status])
    |> cast_assoc(:toys)
    |> validate_required([:name, :owner_id, :status])
    |> validate_inclusion(:status, ["alive", "dead"])
    |> foreign_key_constraint(:owner_id)
  end

  def create_or_update(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert(
      returning: true,
      on_conflict: {:replace_all_except, [:id, :inserted_at]},
      conflict_target:
        {:unsafe_fragment, "(owner_id, status) WHERE status = 'alive'"}
    )
  end
end
