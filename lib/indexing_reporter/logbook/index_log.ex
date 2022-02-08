defmodule IndexingReporter.Logbook.IndexLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "index_logs" do
    field :count, :integer
    field :date, :date
    field :remarks, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(index_log, attrs) do
    index_log
    |> cast(attrs, [:user_id, :date, :count, :remarks])
    |> validate_required([:user_id, :date, :count])
  end
end
