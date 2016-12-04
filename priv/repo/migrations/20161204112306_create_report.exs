defmodule Sapat.Repo.Migrations.CreateReport do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :description, :string
      add :lat, :float
      add :lng, :float

      timestamps()
    end

  end
end
