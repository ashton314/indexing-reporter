defmodule IndexingReporter.Logbook do
  @moduledoc """
  The Logbook context.
  """

  import Ecto.Query, warn: false
  alias IndexingReporter.Repo

  alias IndexingReporter.Logbook.IndexLog

  @doc """
  Returns the list of index_logs.

  ## Examples

      iex> list_index_logs()
      [%IndexLog{}, ...]

  """
  def list_index_logs(user_id) do
    query = from l in IndexLog,
      where: l.user_id == ^user_id

    Repo.all(query)
  end

  @doc """
  Gets a single index_log.

  Raises `Ecto.NoResultsError` if the Index log does not exist.

  ## Examples

      iex> get_index_log!(123)
      %IndexLog{}

      iex> get_index_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_index_log!(id), do: Repo.get!(IndexLog, id)

  @doc """
  Creates a index_log.

  ## Examples

      iex> create_index_log(%{field: value})
      {:ok, %IndexLog{}}

      iex> create_index_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_index_log(attrs \\ %{}) do
    %IndexLog{}
    |> IndexLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a index_log.

  ## Examples

      iex> update_index_log(index_log, %{field: new_value})
      {:ok, %IndexLog{}}

      iex> update_index_log(index_log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_index_log(%IndexLog{} = index_log, attrs) do
    index_log
    |> IndexLog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a index_log.

  ## Examples

      iex> delete_index_log(index_log)
      {:ok, %IndexLog{}}

      iex> delete_index_log(index_log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_index_log(%IndexLog{} = index_log) do
    Repo.delete(index_log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking index_log changes.

  ## Examples

      iex> change_index_log(index_log)
      %Ecto.Changeset{data: %IndexLog{}}

  """
  def change_index_log(%IndexLog{} = index_log, attrs \\ %{}) do
    IndexLog.changeset(index_log, attrs)
  end
end
