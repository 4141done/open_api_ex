defmodule OpenApiFun.ProfessionalsTest do
  use OpenApiFun.DataCase

  alias OpenApiFun.Professionals

  describe "lawyers" do
    alias OpenApiFun.Professionals.Lawyer

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def lawyer_fixture(attrs \\ %{}) do
      {:ok, lawyer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Professionals.create_lawyer()

      lawyer
    end

    test "list_lawyers/0 returns all lawyers" do
      lawyer = lawyer_fixture()
      assert Professionals.list_lawyers() == [lawyer]
    end

    test "get_lawyer!/1 returns the lawyer with given id" do
      lawyer = lawyer_fixture()
      assert Professionals.get_lawyer!(lawyer.id) == lawyer
    end

    test "create_lawyer/1 with valid data creates a lawyer" do
      assert {:ok, %Lawyer{} = lawyer} = Professionals.create_lawyer(@valid_attrs)
      assert lawyer.name == "some name"
    end

    test "create_lawyer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Professionals.create_lawyer(@invalid_attrs)
    end

    test "update_lawyer/2 with valid data updates the lawyer" do
      lawyer = lawyer_fixture()
      assert {:ok, lawyer} = Professionals.update_lawyer(lawyer, @update_attrs)
      assert %Lawyer{} = lawyer
      assert lawyer.name == "some updated name"
    end

    test "update_lawyer/2 with invalid data returns error changeset" do
      lawyer = lawyer_fixture()
      assert {:error, %Ecto.Changeset{}} = Professionals.update_lawyer(lawyer, @invalid_attrs)
      assert lawyer == Professionals.get_lawyer!(lawyer.id)
    end

    test "delete_lawyer/1 deletes the lawyer" do
      lawyer = lawyer_fixture()
      assert {:ok, %Lawyer{}} = Professionals.delete_lawyer(lawyer)
      assert_raise Ecto.NoResultsError, fn -> Professionals.get_lawyer!(lawyer.id) end
    end

    test "change_lawyer/1 returns a lawyer changeset" do
      lawyer = lawyer_fixture()
      assert %Ecto.Changeset{} = Professionals.change_lawyer(lawyer)
    end
  end
end
