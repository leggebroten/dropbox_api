defmodule DropboxApi.Repo do
  use Ecto.Repo,
    otp_app: :dropbox_api,
    adapter: Ecto.Adapters.Postgres
end
