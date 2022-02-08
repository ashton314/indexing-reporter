defmodule IndexingReporter.LogbookTest do
  use IndexingReporter.DataCase

  alias IndexingReporter.Logbook

  describe "index_logs" do
    alias IndexingReporter.Logbook.IndexLog

    import IndexingReporter.LogbookFixtures

    @invalid_attrs %{count: nil, date: nil, remarks: nil}

    test "list_index_logs/0 returns all index_logs" do
      index_log = index_log_fixture()
      assert Logbook.list_index_logs() == [index_log]
    end

    test "get_index_log!/1 returns the index_log with given id" do
      index_log = index_log_fixture()
      assert Logbook.get_index_log!(index_log.id) == index_log
    end

    test "create_index_log/1 with valid data creates a index_log" do
      valid_attrs = %{count: 42, date: ~D[2022-02-07], remarks: "some remarks"}

      assert {:ok, %IndexLog{} = index_log} = Logbook.create_index_log(valid_attrs)
      assert index_log.count == 42
      assert index_log.date == ~D[2022-02-07]
      assert index_log.remarks == "some remarks"
    end

    test "create_index_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logbook.create_index_log(@invalid_attrs)
    end

    test "update_index_log/2 with valid data updates the index_log" do
      index_log = index_log_fixture()
      update_attrs = %{count: 43, date: ~D[2022-02-08], remarks: "some updated remarks"}

      assert {:ok, %IndexLog{} = index_log} = Logbook.update_index_log(index_log, update_attrs)
      assert index_log.count == 43
      assert index_log.date == ~D[2022-02-08]
      assert index_log.remarks == "some updated remarks"
    end

    test "update_index_log/2 with invalid data returns error changeset" do
      index_log = index_log_fixture()
      assert {:error, %Ecto.Changeset{}} = Logbook.update_index_log(index_log, @invalid_attrs)
      assert index_log == Logbook.get_index_log!(index_log.id)
    end

    test "delete_index_log/1 deletes the index_log" do
      index_log = index_log_fixture()
      assert {:ok, %IndexLog{}} = Logbook.delete_index_log(index_log)
      assert_raise Ecto.NoResultsError, fn -> Logbook.get_index_log!(index_log.id) end
    end

    test "change_index_log/1 returns a index_log changeset" do
      index_log = index_log_fixture()
      assert %Ecto.Changeset{} = Logbook.change_index_log(index_log)
    end
  end
end
