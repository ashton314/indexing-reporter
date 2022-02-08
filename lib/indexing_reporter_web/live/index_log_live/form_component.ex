defmodule IndexingReporterWeb.IndexLogLive.FormComponent do
  use IndexingReporterWeb, :live_component

  alias IndexingReporter.Logbook

  @impl true
  def update(%{index_log: index_log} = assigns, socket) do
    changeset = Logbook.change_index_log(index_log)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"index_log" => index_log_params}, socket) do
    changeset =
      socket.assigns.index_log
      |> Logbook.change_index_log(index_log_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"index_log" => index_log_params}, socket) do
    save_index_log(socket, socket.assigns.action, index_log_params)
  end

  defp save_index_log(socket, :edit, index_log_params) do
    case Logbook.update_index_log(socket.assigns.index_log, index_log_params) do
      {:ok, _index_log} ->
        {:noreply,
         socket
         |> put_flash(:info, "Index log updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_index_log(socket, :new, index_log_params) do
    case Logbook.create_index_log(index_log_params) do
      {:ok, _index_log} ->
        {:noreply,
         socket
         |> put_flash(:info, "Index log created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
