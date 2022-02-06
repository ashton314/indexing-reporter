defmodule IndexingReporterWeb.PageController do
  use IndexingReporterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
