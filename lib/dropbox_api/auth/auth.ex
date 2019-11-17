defmodule DropboxApi.Auth do
  use HTTPoison.Base

  @doc """
  Returns URL the user needs to hit to authorize this app's access to their Dropbox account.

  When the user has authorized access, Dropbox will call the redirect URl with the authorization
  code.  This code must then be passed back to Dropbox to obtain a Bearer token
  """
  def authorize_app_url() do
    "#{dropbox_auth_url()}?client_id=#{app_key()}&response_type=code&state=#{state()}&redirect_uri=#{
      redirect_url()
    }"
  end

  @doc """
  Pass the authorization_code to Dropbox to obtain a Bearer token
  """
  def authenticate(authorization_code) do
    body =
      %{code: authorization_code, grant_type: "authorization_code", redirect_uri: redirect_url()}
      |> URI.encode_query()

    header = [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Authorization", "Basic OGt3bHJidWk5NWNxeDY2OnUxcGt1MGFycW9pb29raA=="}
    ]

    case post(dropbox_token_url(), body, header) do
      {:ok, %{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      error ->
        IO.puts("error #{error}")
        {:error, error}
    end
  end

  def token(%{"access_token" => token}), do: token
  def uid(%{"uid" => uid}), do: uid
  def account_id(%{"account_id" => account_id}), do: account_id

  defp state() do
    "42"
  end

  defp dropbox_auth_url, do: Application.fetch_env!(:dropbox_api, :auth_url)
  defp dropbox_token_url, do: Application.fetch_env!(:dropbox_api, :token_url)
  defp app_key, do: Application.fetch_env!(:dropbox_api, :app_key)
  defp app_secret, do: Application.fetch_env!(:dropbox_api, :app_secret)
  defp redirect_url, do: Application.fetch_env!(:dropbox_api, :redirect_url)
  defp authenticate_timeout, do: Application.fetch_env!(:dropbox_api, :authenticate_timeout)
end
