defmodule OpenApiFunWeb.LawyerController do
  use OpenApiFunWeb, :controller

  alias OpenApiFun.Professionals
  alias OpenApiFun.Professionals.Lawyer

  action_fallback OpenApiFunWeb.FallbackController

  def index(conn, _params) do
    lawyers = Professionals.list_lawyers()
    render(conn, "index.json", lawyers: lawyers)
  end

  def create(conn, %{"lawyer" => lawyer_params}) do
    with {:ok, %Lawyer{} = lawyer} <- Professionals.create_lawyer(lawyer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", lawyer_path(conn, :show, lawyer))
      |> render("show.json", lawyer: lawyer)
    end
  end

  def show(conn, %{"id" => id}) do
    lawyer = Professionals.get_lawyer!(id)
    render(conn, "show.json", lawyer: lawyer)
  end

  def update(conn, %{"id" => id, "lawyer" => lawyer_params}) do
    lawyer = Professionals.get_lawyer!(id)

    with {:ok, %Lawyer{} = lawyer} <- Professionals.update_lawyer(lawyer, lawyer_params) do
      render(conn, "show.json", lawyer: lawyer)
    end
  end

  def delete(conn, %{"id" => id}) do
    lawyer = Professionals.get_lawyer!(id)
    with {:ok, %Lawyer{}} <- Professionals.delete_lawyer(lawyer) do
      send_resp(conn, :no_content, "")
    end
  end
end
