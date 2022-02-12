defmodule IndexingReporterWeb.AdminIndexLive.AdminIndex do
  use IndexingReporterWeb, :live_view
  on_mount IndexingReporterWeb.UserLiveAuth

  alias IndexingReporter.Logbook
  alias IndexingReporter.Logbook.IndexLog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :user_stats, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  # defp apply_action(socket, :edit, %{"id" => id}) do
  #   socket
  #   |> assign(:page_title, "Edit Index log")
  #   |> assign(:index_log, Logbook.get_index_log!(id))
  # end

  # defp apply_action(socket, :new, _params) do
  #   socket
  #   |> assign(:page_title, "New Index log")
  #   |> assign(:index_log, %IndexLog{})
  #   |> assign(:current_user, socket.assigns.current_user)
  # end

  defp apply_action(socket, :index, _params) do
    logs = Logbook.list_index_logs(socket.assigns.current_user.id)
    total = logs |> Enum.reduce(0, fn %IndexLog{count: c}, acc -> c + acc end)

    socket
    |> assign(:page_title, "Admin | Top Indexers")
    |> assign(:total_indexing, total)
  end
end
