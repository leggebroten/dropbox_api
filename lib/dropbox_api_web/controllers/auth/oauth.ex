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
    case Auth.authenticate(conn) do
      {:ok, auth} ->
        access_token = Auth.access_token(auth)
        conn = Plug.Conn.put_resp_cookie(conn, "bearer_token", access_token)

        # todo get web url from original request
        redirect(conn, external: "http://localhost:8000")

      {:error, error} ->
        send_resp(conn, 500, "#{error}")
    end
  end
end
