defmodule DropboxApiWeb.OAuth do
  use DropboxApiWeb, :controller

  def oauth(conn, _) do
    send_authorization_code(conn)

    send_resp(conn, 200, "oauth: code=#{conn.params["code"]}, state=#{conn.params["state"]}")
  end

  defp send_authorization_code(conn) do
    send pid(conn), {:ok, conn.params["code"]}
  end

  defp pid(conn) do
    IEx.Helpers.pid(conn.params["state"])
  end
end
