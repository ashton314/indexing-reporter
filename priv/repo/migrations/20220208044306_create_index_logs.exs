defmodule IndexingReporter.Repo.Migrations.CreateIndexLogs do
  use Ecto.Migration

  def change do
    create table(:index_logs) do
      add :date, :date
      add :count, :integer
      add :remarks, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:index_logs, [:user_id])
  end
end
