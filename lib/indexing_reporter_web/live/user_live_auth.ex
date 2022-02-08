defmodule IndexingReporterWeb.UserLiveAuth do
  import Phoenix.LiveView
  alias IndexingReporter.Accounts

  def on_mount(:default, _params, %{"user_token" => user_token} = _session, socket) do
    # socket = assign_new(socket, :current_user, fn ->
    #   Accounts.get_user!(user_id)
    # end)

    usr = user_token && Accounts.get_user_by_session_token(user_token)

    socket = assign(socket, :current_user, usr)

    # if socket.assigns.current_user.confirmed_at do
    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/login")}
    end
  end

  # def on_mount(:default, _params, session, socket) do
  #   IO.inspect(session, label: "session")

  #   {:cont, socket}
  # end
end
