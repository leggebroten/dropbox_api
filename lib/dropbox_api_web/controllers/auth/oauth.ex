defmodule DropboxApiWeb.OAuth do
  use DropboxApiWeb, :controller

  alias DropboxApi.Auth

  def oath(conn, _) do
    render(conn, "index.html")
  end

  def login(conn, _) do
    redirect(conn, external: Auth.authorize_app_url())
  end

  def oauthredirect(conn, _) do
    case Auth.authenticate(conn.params["code"]) do
      {:ok, auth} ->
        token = Auth.token(auth)
        conn = Plug.Conn.put_resp_cookie(conn, "bearer_token", token)

        redirect(conn, external: "http://localhost:8000")

      {:error, error} ->
        send_resp(conn, 500, "#{error}")
    end
  end
end
