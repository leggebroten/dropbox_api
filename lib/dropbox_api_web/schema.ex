defmodule DropboxApiWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types DropboxApiWeb.Schema.HealthTypes
  import_types DropboxApiWeb.Schema.AuthTypes

  alias DropboxApi.Resolvers

  query do

    @desc "health basic test of system running"
    field :health, :health do
      resolve &Resolvers.Health.show_health/3
    end
  end

  mutation do
    field :create_auth, :auth do
      resolve &Resolvers.Auth.log_in/3
    end
  end
end