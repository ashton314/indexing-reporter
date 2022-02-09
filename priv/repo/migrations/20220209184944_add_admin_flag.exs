defmodule IndexingReporter.Repo.Migrations.AddAdminFlag do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :adminp, :boolean, default: false
    end
  end
end
