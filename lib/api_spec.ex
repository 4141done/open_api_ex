defmodule OpenApiFun.ApiSpec do
  alias OpenApiSpex.{OpenApi, Server, Info, Paths}

  def spec do
    %OpenApi{
      servers: [
        # Populate the Server info from a phoenix endpoint
        Server.from_endpoint(OpenApiFunWeb.Endpoint, otp_app: :open_api_fun)
      ],
      info: %Info{
        title: "Open Api fun",
        version: "0.0.1"
      },
      # populate the paths from a phoenix router
      paths: Paths.from_router(OpenApiFunWeb.Router)
    }
    |> OpenApiSpex.resolve_schema_modules() # discover request/response schemas from path specs
  end
end
