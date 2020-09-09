defmodule RedditWeb.Types.User do
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id |> non_null
    field :username, :string |> non_null
    field :email, :string |> non_null
    field :token, :string
  end

  object :user_response do
    field :user, :user
    field :error_message, :string
  end
end
