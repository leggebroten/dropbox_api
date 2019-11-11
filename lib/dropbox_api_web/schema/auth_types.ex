defmodule DropboxApiWeb.Schema.AuthTypes do
  use Absinthe.Schema.Notation

  object :auth do
    field :token, :string
  end
end