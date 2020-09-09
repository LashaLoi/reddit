defmodule RedditWeb.Types.Post do
  use Absinthe.Schema.Notation

  object :post do
    field :id, :id |> non_null
    field :title, :string |> non_null
    field :description, :string |> non_null
  end
end
