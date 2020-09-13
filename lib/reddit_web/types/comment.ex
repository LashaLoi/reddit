defmodule RedditWeb.Types.Comment do
  use Absinthe.Schema.Notation

  object :comment do
    field :id, :id |> non_null
    field :text, :string |> non_null
    field :username, :string |> non_null

    field :inserted_at, :string |> non_null
    field :updated_at, :string |> non_null
  end
end
