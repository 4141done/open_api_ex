defmodule OpenApiFun.Schemas do
  alias OpenApiSpex.Schema

  defmodule Lawyer do
    @behaviour OpenApiSpex.Schema
    @derive [Poison.Encoder]
    @schema %Schema{
      title: "Lawyer",
      description: "A lawyer in the Avvo system",
      type: :object,
      properties: %{
        id: %Schema{type: :integer, description: "Lawyer ID"},
        name: %Schema{type: :string, description: "The Lawyer's full name"},
        inserted_at: %Schema{type: :string, description: "Creation timestamp", format: :datetime},
        updated_at: %Schema{type: :string, description: "Update timestamp", format: :datetime}
      },
      required: [:name],
      example: %{
        "id" => 123,
      }
    }

    def schema, do: @schema
    defstruct Map.keys(@schema.properties)
  end

  defmodule LawyerResponse do
    require OpenApiSpex

    OpenApiSpex.schema %{
      title: "LawyerResponse",
      description: "Response schema for single lawyer",
      type: :object,
      properties: %{
        data: Lawyer
      }
    }
  end
end
