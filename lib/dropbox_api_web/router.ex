defmodule DropboxApiWeb.Router do
  use DropboxApiWeb, :router

  get "/oathredirect", DropboxApiWeb.OAuth, :oauth

  forward "/graphql", Absinthe.Plug,
          schema: DropboxApiWeb.Schema
end
