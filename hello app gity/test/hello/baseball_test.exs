defmodule Hello.BaseballTest do
  use Hello.DataCase

  alias Hello.Baseball

  describe "paintings" do
    alias Hello.Baseball.Painting

    import Hello.BaseballFixtures

    @invalid_attrs %{name: nil, dataarray: nil}

    test "list_paintings/0 returns all paintings" do
      painting = painting_fixture()
      assert Baseball.list_paintings() == [painting]
    end

    test "get_painting!/1 returns the painting with given id" do
      painting = painting_fixture()
      assert Baseball.get_painting!(painting.id) == painting
    end

    test "create_painting/1 with valid data creates a painting" do
      valid_attrs = %{name: "some name", dataarray: "some dataarray"}

      assert {:ok, %Painting{} = painting} = Baseball.create_painting(valid_attrs)
      assert painting.name == "some name"
      assert painting.dataarray == "some dataarray"
    end

    test "create_painting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Baseball.create_painting(@invalid_attrs)
    end

    test "update_painting/2 with valid data updates the painting" do
      painting = painting_fixture()
      update_attrs = %{name: "some updated name", dataarray: "some updated dataarray"}

      assert {:ok, %Painting{} = painting} = Baseball.update_painting(painting, update_attrs)
      assert painting.name == "some updated name"
      assert painting.dataarray == "some updated dataarray"
    end

    test "update_painting/2 with invalid data returns error changeset" do
      painting = painting_fixture()
      assert {:error, %Ecto.Changeset{}} = Baseball.update_painting(painting, @invalid_attrs)
      assert painting == Baseball.get_painting!(painting.id)
    end

    test "delete_painting/1 deletes the painting" do
      painting = painting_fixture()
      assert {:ok, %Painting{}} = Baseball.delete_painting(painting)
      assert_raise Ecto.NoResultsError, fn -> Baseball.get_painting!(painting.id) end
    end

    test "change_painting/1 returns a painting changeset" do
      painting = painting_fixture()
      assert %Ecto.Changeset{} = Baseball.change_painting(painting)
    end
  end
end
