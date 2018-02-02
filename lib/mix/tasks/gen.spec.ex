defmodule Mix.Tasks.App.Gen.Spec do
  def run([output_file]) do
    json = OpenApiFun.ApiSpec.spec() |> Poison.encode!(pretty: true)

    :ok = File.write!(output_file, json)
  end
end
