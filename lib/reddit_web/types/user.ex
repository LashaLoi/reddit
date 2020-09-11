defmodule RedditWeb.Types.User do
  use Absinthe.Schema.Notation

  alias RedditWeb.Resolvers.User

  object :user do
    field :id, :id |> non_null
    field :username, :string |> non_null
    field :email, :string |> non_null

    field :inserted_at, :string
    field :updated_at, :string

    field :token, :string

    field :posts, :post |> list_of do
      arg(:limit, :integer, default_value: nil)
      arg(:offset, :integer, default_value: nil)

      resolve(&User.get_posts/3)
    end
  end

  object :user_response do
    field :user, :user
    field :error_message, :string
  end
end
