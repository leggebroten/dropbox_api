defmodule DropboxApiWeb.Router do
  use DropboxApiWeb, :router

  get "/oath", DropboxApiWeb.OAuth, :oauth
  get "/login", DropboxApiWeb.OAuth, :login
  get "/oathredirect", DropboxApiWeb.OAuth, :oauthredirect

  forward "/graphql", Absinthe.Plug,
          schema: DropboxApiWeb.Schema
end
