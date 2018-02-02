defmodule OpenApiFunWeb.LawyerControllerTest do
  use OpenApiFunWeb.ConnCase

  alias OpenApiFun.Professionals
  alias OpenApiFun.Professionals.Lawyer

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:lawyer) do
    {:ok, lawyer} = Professionals.create_lawyer(@create_attrs)
    lawyer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all lawyers", %{conn: conn} do
      conn = get conn, lawyer_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create lawyer" do
    test "renders lawyer when data is valid", %{conn: conn} do
      conn = post conn, lawyer_path(conn, :create), lawyer: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, lawyer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, lawyer_path(conn, :create), lawyer: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update lawyer" do
    setup [:create_lawyer]

    test "renders lawyer when data is valid", %{conn: conn, lawyer: %Lawyer{id: id} = lawyer} do
      conn = put conn, lawyer_path(conn, :update, lawyer), lawyer: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, lawyer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, lawyer: lawyer} do
      conn = put conn, lawyer_path(conn, :update, lawyer), lawyer: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete lawyer" do
    setup [:create_lawyer]

    test "deletes chosen lawyer", %{conn: conn, lawyer: lawyer} do
      conn = delete conn, lawyer_path(conn, :delete, lawyer)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, lawyer_path(conn, :show, lawyer)
      end
    end
  end

  defp create_lawyer(_) do
    lawyer = fixture(:lawyer)
    {:ok, lawyer: lawyer}
  end
end
