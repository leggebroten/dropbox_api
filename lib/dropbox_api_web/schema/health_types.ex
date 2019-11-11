defmodule DropboxApiWeb.Schema.HealthTypes do
  use Absinthe.Schema.Notation

  object :health do
    field :body, :string
  end
end