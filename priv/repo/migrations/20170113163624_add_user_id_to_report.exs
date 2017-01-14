defmodule Sapat.Repo.Migrations.AddUserIdToReport do
  use Ecto.Migration

  def change do
    alter table(:reports) do
      add :user_id, references(:users, on_delete: :nothing)
    end

    create index(:reports, [:user_id])
  end
end
