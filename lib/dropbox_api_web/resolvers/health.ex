defmodule DropboxApi.Resolvers.Health do
  def show_health(_parent, _args, _resolution) do
    {:ok, %{body: "hi there"}}
  end
end