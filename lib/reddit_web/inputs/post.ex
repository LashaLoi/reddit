defmodule RedditWeb.Inputs.Post do
  use Absinthe.Schema.Notation

  input_object :create_post_input do
    field :title, :string |> non_null
    field :description, :string |> non_null
    field :user_id, :string |> non_null
  end
end
