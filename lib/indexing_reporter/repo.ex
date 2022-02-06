defmodule IndexingReporter.Repo do
  use Ecto.Repo,
    otp_app: :indexing_reporter,
    adapter: Ecto.Adapters.Postgres
end
