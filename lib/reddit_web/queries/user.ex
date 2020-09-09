defmodule RedditWeb.Queries.User do
  use Absinthe.Schema.Notation

  alias RedditWeb.Resolvers.User

  import_types(RedditWeb.Types.User)
  import_types(RedditWeb.Inputs.User)

  object :user_queries do
    field :me, :user do
      resolve(fn _root, _arg, _info ->
        {:ok,
         %{
           id: 1,
           username: "Alex",
           email: "lashaloi1409@gmail.com"
         }}
      end)
    end
  end

  object :user_mutations do
    field :login, :user do
      arg(:username, :string |> non_null)
      arg(:password, :string |> non_null)

      resolve(&User.login/3)
    end

    field :register, :user do
      arg(:input, :create_user_input |> non_null)

      resolve(&User.register/3)
    end
  end
end
