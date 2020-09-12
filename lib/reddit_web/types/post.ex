defmodule RedditWeb.Types.Post do
  use Absinthe.Schema.Notation

  object :user_by_post do
    field :id, :id |> non_null
    field :username, :string |> non_null
    field :email, :string |> non_null

    field :inserted_at, :string
    field :updated_at, :string
  end

  object :post do
    field :id, :id |> non_null
    field :title, :string |> non_null
    field :description, :string |> non_null
    field :user, :user_by_post |> non_null
    field :inserted_at, :string
    field :updated_at, :string
  end

  object :post_response do
    field :post, :post
    field :error_message, :string
  end
end
