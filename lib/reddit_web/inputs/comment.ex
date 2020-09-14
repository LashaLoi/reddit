defmodule RedditWeb.Inputs.Comment do
  use Absinthe.Schema.Notation

  input_object :create_comment_input do
    field(:username, :string |> non_null)
    field(:text, :string |> non_null)
    field(:post_id, :id |> non_null)
  end
end
