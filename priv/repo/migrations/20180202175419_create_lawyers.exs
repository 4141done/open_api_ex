defmodule OpenApiFun.Repo.Migrations.CreateLawyers do
  use Ecto.Migration

  def change do
    create table(:lawyers) do
      add :name, :string

      timestamps()
    end

  end
end
