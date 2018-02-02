defmodule OpenApiFunWeb.LawyerController do
  use OpenApiFunWeb, :controller
  alias OpenApiSpex.Operation
  alias OpenApiFun.Schemas.{Lawyer, LawyerResponse}

  alias OpenApiFun.Professionals
  alias OpenApiFun.Professionals.Lawyer

  action_fallback OpenApiFunWeb.FallbackController

  @spec open_api_operation(any) :: Operation.t
  def open_api_operation(action), do: apply(__MODULE__, :"#{action}_operation", [])

  # def index(conn, _params) do
  #   lawyers = Professionals.list_lawyers()
  #   render(conn, "index.json", lawyers: lawyers)
  # end

  # def create(conn, %{"lawyer" => lawyer_params}) do
  #   with {:ok, %Lawyer{} = lawyer} <- Professionals.create_lawyer(lawyer_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", lawyer_path(conn, :show, lawyer))
  #     |> render("show.json", lawyer: lawyer)
  #   end
  # end


  @spec show_operation :: Operation.t
  def show_operation() do
    %Operation{
      tags: ["lawyers"],
      summary: "Show Lawyer",
      description: "Show a lawyer by id",
      operationId: "LawyerController.show",
      parameters: [
        Operation.parameter(:id, :path, :integer, "Lawyer ID", example: 123)
      ],
      responses: %{
        200 => Operation.response("Lawyer", "application/json", LawyerResponse)
      }
    }
  end

  def show(conn, %{"id" => id}) do
    IO.puts id
    IO.inspect Professionals.get_lawyer!(id)
    case Professionals.get_lawyer!(id) do
      nil -> {:error, :not_found}
      lawyer -> json(conn, LawyerResponse{
        data: lawyer
      })
    end
  end

  # def update(conn, %{"id" => id, "lawyer" => lawyer_params}) do
  #   lawyer = Professionals.get_lawyer!(id)

  #   with {:ok, %Lawyer{} = lawyer} <- Professionals.update_lawyer(lawyer, lawyer_params) do
  #     render(conn, "show.json", lawyer: lawyer)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   lawyer = Professionals.get_lawyer!(id)
  #   with {:ok, %Lawyer{}} <- Professionals.delete_lawyer(lawyer) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
