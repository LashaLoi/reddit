defmodule RedditWeb.Queries.User do
  use Absinthe.Schema.Notation

  alias RedditWeb.Resolvers.User

  import_types(RedditWeb.Types.User)

  object :user_queries do
    field :me, :user do
      resolve(fn _root, _arg, _info ->
        {:ok,
         %{
           id: 1,
           username: "Alex",
           email: "lashaloi1409@gmail.com",
           password: "password"
         }}
      end)
    end
  end

  object :user_mutations do
    field :login, :string do
      resolve(&User.login/3)
    end

    field :register, :string do
      resolve(&User.register/3)
    end
  end
end
