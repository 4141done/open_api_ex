defmodule OpenApiFun.Professionals.Lawyer do
  use Ecto.Schema
  import Ecto.Changeset
  alias OpenApiFun.Professionals.Lawyer


  schema "lawyers" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Lawyer{} = lawyer, attrs) do
    lawyer
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
