defmodule RedditWeb.Types.User do
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id |> non_null
    field :username, :string |> non_null
    field :email, :string |> non_null
    field :password, :string |> non_null
  end
end
