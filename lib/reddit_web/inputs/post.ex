defmodule RedditWeb.Inputs.Post do
  use Absinthe.Schema.Notation

  input_object :create_post_input do
    field :title, :string |> non_null
    field :description, :string |> non_null
  end

  input_object :posts_input do
    field :limit, :integer, default_value: nil
    field :offset, :integer, default_value: nil
    field :title, :string, default_value: nil
  end
end
