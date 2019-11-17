defmodule DropboxApi.Resolvers.Auth do

  alias DropboxApi.Auth

  def authorization(_parent, _args, _resolution) do
    {:ok, %{authorization_url: Auth.authorize_app_url()}}
  end

  def authenticate(_parent, %{input: %{auth_code: auth_code}}, _resolution) do
    with {:ok, token} <- Auth.authenticate(auth_code), do: {:ok, %{token: token}}
  end
end
