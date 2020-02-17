defmodule DogRegistry.DogTest do
  use DogRegistry.DataCase, async: true

  alias DogRegistry.Dog
  alias DogRegistry.Owner
  alias DogRegistry.Repo

  @dead_dog_1 %{name: "Clarence", status: "dead"}
  @dead_dog_2 %{name: "Penelope", status: "dead"}
  @dead_dog_3 %{name: "Christopher", status: "dead"}

  @living_dog_1 %{
    name: "Dwayne",
    status: "alive",
    toys: [
      %{product: "round chewie thing", rating: 5},
      %{product: "long catchie thing", rating: 4}
    ]
  }
  @living_dog_2 %{
    name: "Claire",
    status: "alive",
    toys: [%{product: "small squeaky thing", rating: 4}]
  }

  @owner %{name: "Carl Stanton", city: "Dogtown"}

  defp insert_owner!(params) do
    %Owner{}
    |> Owner.changeset(params)
    |> Repo.insert!()
  end

  defp params(dog, owner), do: Map.put(dog, :owner_id, owner.id)

  describe "create_or_update/1" do
    test "creates a dog" do
      owner = insert_owner!(@owner)

      assert {:ok, %Dog{}} = Dog.create_or_update(params(@living_dog_1, owner))
      assert [%Dog{}] = Repo.all(Dog)
    end

    test "allows to add multiple dead dogs" do
      owner = insert_owner!(@owner)

      assert {:ok, %Dog{}} = Dog.create_or_update(params(@dead_dog_1, owner))
      assert {:ok, %Dog{}} = Dog.create_or_update(params(@dead_dog_2, owner))
      assert {:ok, %Dog{}} = Dog.create_or_update(params(@living_dog_1, owner))
      assert {:ok, %Dog{}} = Dog.create_or_update(params(@dead_dog_3, owner))
      assert [_, _, _, _] = Repo.all(Dog)
    end

    test "replaces previous dog if alive" do
      owner = insert_owner!(@owner)

      assert {:ok, %Dog{}} = Dog.create_or_update(params(@living_dog_1, owner))
      assert {:ok, %Dog{}} = Dog.create_or_update(params(@living_dog_2, owner))

      assert [%Dog{name: name}] = Repo.all(Dog)
      assert name == @living_dog_2.name
    end
  end
end
