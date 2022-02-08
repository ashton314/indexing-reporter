defmodule IndexingReporter.LogbookFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IndexingReporter.Logbook` context.
  """

  @doc """
  Generate a index_log.
  """
  def index_log_fixture(attrs \\ %{}) do
    {:ok, index_log} =
      attrs
      |> Enum.into(%{
        count: 42,
        date: ~D[2022-02-07],
        remarks: "some remarks"
      })
      |> IndexingReporter.Logbook.create_index_log()

    index_log
  end
end
