defmodule IndexingReporterWeb.IndexLogLive.Show do
  use IndexingReporterWeb, :live_view

  alias IndexingReporter.Logbook

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:index_log, Logbook.get_index_log!(id))}
  end

  defp page_title(:show), do: "Show Index log"
  defp page_title(:edit), do: "Edit Index log"
end
