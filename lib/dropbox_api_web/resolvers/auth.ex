defmodule DropboxApi.Resolvers.Auth do

  @dropbox_auth_url Application.fetch_env!(:dropbox_api, :auth_url)
  @dropbox_token_url Application.fetch_env!(:dropbox_api, :token_url)
  @app_key Application.fetch_env!(:dropbox_api, :app_key)
  @app_secret Application.fetch_env!(:dropbox_api, :app_secret)
  @redirect_url Application.fetch_env!(:dropbox_api, :redirect_url)
  @authenticate_timeout Application.fetch_env!(:dropbox_api, :authenticate_timeout)

  def log_in(_parent, _args, _resolution) do
    ask_for_authorization()

    with {:ok, authorize_code} <- receive(), do: {:ok, %{token: authorize_code}}
  end

  defp ask_for_authorization do
    auth_url = authorize_app()
    IO.inspect(auth_url, label: "inv auth.ex:27 (auth_url)", pretty: true)
    auth_url
  end

  def receive do
    IO.puts "wait_for_code [#{inspect self()}] is listening"
    IO.puts "send pid(\"#{state()}\"), {:ok, :hello}"
    receive do
      {:ok, message} ->
        IO.puts "[#{inspect self()}] Received #{message}"
        {:ok, message}
    after
      @authenticate_timeout -> {:error, :timeout}
    end
  end

  defp authorize_app() do
    "#{@dropbox_auth_url}?client_id=#{@app_key}&response_type=code&state=#{state()}&redirect_uri=#{@redirect_url}"
  end

  defp state() do
    "#{inspect self()}"
    |> String.slice(5..-2)
  end

  #  @auth_code "XOR2yHGT6TAAAAAAAAAAGBK3IijzD9iyRueQfJFayoM"
#  defp oath_token() do
#    """
#      curl #{@dropbox_token_url} \
#            -d code=#{@auth_code} \
#            -d grant_type=authorization_code \
#            -d redirect_uri=#{@redirect_url} \
#            -u #{@app_key}:#{@app_secret}
#    """
#    |> String.trim()
#  end
end
