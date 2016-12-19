defmodule Sapat.Repo.Migrations.CreatePhoto do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :photo, :string
      add :uuid, :uuid
      add :report_id, references(:reports, on_delete: :nothing)

      timestamps()
    end
    create index(:photos, [:report_id])
    create index(:photos, [:uuid])

  end
end
