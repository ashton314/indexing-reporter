defmodule IndexingReporterWeb.AdminIndexLive.AdminIndex do
  use IndexingReporterWeb, :live_view
  on_mount IndexingReporterWeb.UserLiveAuth

  alias IndexingReporter.Logbook.IndexLog
  alias IndexingReporter.Accounts.User
  alias IndexingReporter.Repo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :user_stats, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    {total, listing} = get_stats()

    socket
    |> assign(:page_title, "Admin | Top Indexers")
    |> assign(:total_indexing, total)
    |> assign(:listing, listing)
  end

  def get_stats() do
    import Ecto.Query

    listing_query = from u in User,
      join: l in IndexLog, on: u.id == l.user_id,
      group_by: u.id,
      order_by: [desc: sum(l.count), asc: u.id],
      select: %{id: u.id, name: u.name, email: u.email, total: sum(l.count)}
      # select: {u.name, over(sum(l.count), partition_by: u.id)}

    total_query = from l in IndexLog, select: {sum(l.count)}
    {total} = Repo.one(total_query)

    {total, Repo.all(listing_query)}
  end
end
