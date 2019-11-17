defmodule DropboxApiWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types DropboxApiWeb.Schema.AuthTypes

  alias DropboxApi.Resolvers

  query do

    @desc "Authorization URL needed to have user authorize this app's access to their Dropbox"
    field :authorization, :authorization_payload do
      resolve &Resolvers.Auth.authorization/3
    end
  end

  mutation do
    @desc "With an authorization code, request an authentication token used for everything else"
    field :authenticate, :authenticate_payload do
      arg(:input, non_null(:authenticate_input))

      resolve &Resolvers.Auth.authenticate/3
    end
  end
end