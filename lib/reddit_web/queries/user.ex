defmodule RedditWeb.Queries.User do
  use Absinthe.Schema.Notation

  alias RedditWeb.Resolvers.User

  import_types(RedditWeb.Types.User)
  import_types(RedditWeb.Inputs.User)

  object :user_queries do
    field :me, :user do
      middleware(Middlewares.Auth)
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

    field :forgot_password, :boolean do
      arg(:new_password, :string |> non_null)
      arg(:confirm_new_password, :string |> non_null)

      middleware(Middlewares.Auth)
      resolve(&User.forgot_password/3)
    end
  end
end
