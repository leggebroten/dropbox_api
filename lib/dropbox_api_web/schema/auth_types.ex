defmodule DropboxApiWeb.Schema.AuthTypes do
  use Absinthe.Schema.Notation

  object :authorization_payload do
    field :authorization_url, :string
  end

  input_object :authenticate_input do
    field(:auth_code, non_null(:string))
  end

  object :authenticate_payload do
    field :access_token, non_null(:string)
    field :account_id, non_null(:string)
    field :uid, non_null(:string)
  end
end