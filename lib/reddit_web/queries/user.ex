defmodule RedditWeb.Queries.User do
  use Absinthe.Schema.Notation

  alias RedditWeb.Resolvers.User

  import_types(RedditWeb.Types.User)
  import_types(RedditWeb.Inputs.User)

  object :user_queries do
    field :me, :user do
      resolve(&User.me/3)
    end
  end

  object :user_mutations do
    field :login, :user_response do
      arg(:username, :string |> non_null)
      arg(:password, :string |> non_null)

      resolve(&User.login/3)
    end

    field :register, :user_response do
      arg(:input, :create_user_input |> non_null)

      resolve(&User.register/3)
    end
  end
end
