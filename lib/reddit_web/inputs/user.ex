defmodule RedditWeb.Inputs.User do
  use Absinthe.Schema.Notation

  input_object :create_user_input do
    field :username, :string |> non_null
    field :email, :string |> non_null
    field :password, :string |> non_null
  end
end
