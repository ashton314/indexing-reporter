defmodule IndexingReporterWeb.IndexLogLiveTest do
  use IndexingReporterWeb.ConnCase

  import Phoenix.LiveViewTest
  import IndexingReporter.LogbookFixtures

  @create_attrs %{count: 42, date: %{day: 7, month: 2, year: 2022}, remarks: "some remarks"}
  @update_attrs %{count: 43, date: %{day: 8, month: 2, year: 2022}, remarks: "some updated remarks"}
  @invalid_attrs %{count: nil, date: %{day: 30, month: 2, year: 2022}, remarks: nil}

  defp create_index_log(_) do
    index_log = index_log_fixture()
    %{index_log: index_log}
  end

  describe "Index" do
    setup [:create_index_log]

    test "lists all index_logs", %{conn: conn, index_log: index_log} do
      {:ok, _index_live, html} = live(conn, Routes.index_log_index_path(conn, :index))

      assert html =~ "Listing Index logs"
      assert html =~ index_log.remarks
    end

    test "saves new index_log", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.index_log_index_path(conn, :index))

      assert index_live |> element("a", "New Index log") |> render_click() =~
               "New Index log"

      assert_patch(index_live, Routes.index_log_index_path(conn, :new))

      assert index_live
             |> form("#index_log-form", index_log: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#index_log-form", index_log: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.index_log_index_path(conn, :index))

      assert html =~ "Index log created successfully"
      assert html =~ "some remarks"
    end

    test "updates index_log in listing", %{conn: conn, index_log: index_log} do
      {:ok, index_live, _html} = live(conn, Routes.index_log_index_path(conn, :index))

      assert index_live |> element("#index_log-#{index_log.id} a", "Edit") |> render_click() =~
               "Edit Index log"

      assert_patch(index_live, Routes.index_log_index_path(conn, :edit, index_log))

      assert index_live
             |> form("#index_log-form", index_log: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#index_log-form", index_log: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.index_log_index_path(conn, :index))

      assert html =~ "Index log updated successfully"
      assert html =~ "some updated remarks"
    end

    test "deletes index_log in listing", %{conn: conn, index_log: index_log} do
      {:ok, index_live, _html} = live(conn, Routes.index_log_index_path(conn, :index))

      assert index_live |> element("#index_log-#{index_log.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#index_log-#{index_log.id}")
    end
  end

  describe "Show" do
    setup [:create_index_log]

    test "displays index_log", %{conn: conn, index_log: index_log} do
      {:ok, _show_live, html} = live(conn, Routes.index_log_show_path(conn, :show, index_log))

      assert html =~ "Show Index log"
      assert html =~ index_log.remarks
    end

    test "updates index_log within modal", %{conn: conn, index_log: index_log} do
      {:ok, show_live, _html} = live(conn, Routes.index_log_show_path(conn, :show, index_log))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Index log"

      assert_patch(show_live, Routes.index_log_show_path(conn, :edit, index_log))

      assert show_live
             |> form("#index_log-form", index_log: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#index_log-form", index_log: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.index_log_show_path(conn, :show, index_log))

      assert html =~ "Index log updated successfully"
      assert html =~ "some updated remarks"
    end
  end
end
