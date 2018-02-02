# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     OpenApiFun.Repo.insert!(%OpenApiFun.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias OpenApiFun.Professionals.Lawyer
alias OpenApiFun.Repo

%Lawyer{}
|> Lawyer.changeset(%{name: "Steve"})
|> Repo.insert!
