defmodule OpenApiFunWeb.LawyerView do
  use OpenApiFunWeb, :view
  alias OpenApiFunWeb.LawyerView

  def render("index.json", %{lawyers: lawyers}) do
    %{data: render_many(lawyers, LawyerView, "lawyer.json")}
  end

  def render("show.json", %{lawyer: lawyer}) do
    %{data: render_one(lawyer, LawyerView, "lawyer.json")}
  end

  def render("lawyer.json", %{lawyer: lawyer}) do
    %{id: lawyer.id,
      name: lawyer.name}
  end
end
