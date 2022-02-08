defmodule IndexingReporterWeb.IndexLogLive.Index do
  use IndexingReporterWeb, :live_view
  on_mount IndexingReporterWeb.UserLiveAuth

  alias IndexingReporter.Logbook
  alias IndexingReporter.Logbook.IndexLog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :index_logs, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Index log")
    |> assign(:index_log, Logbook.get_index_log!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Index log")
    |> assign(:index_log, %IndexLog{})
    |> assign(:current_user, socket.assigns.current_user)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Indexing logs")
    |> assign(:index_log, nil)
    |> assign(:index_logs, Logbook.list_index_logs(socket.assigns.current_user.id))
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    index_log = Logbook.get_index_log!(id)
    {:ok, _} = Logbook.delete_index_log(index_log)

    {:noreply, assign(socket, :index_logs, list_index_logs(socket.current_user))}
  end

  defp list_index_logs(user) do
    Logbook.list_index_logs(user.id)
  end
end
