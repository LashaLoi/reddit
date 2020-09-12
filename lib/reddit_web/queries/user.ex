defmodule RedditWeb.Queries.User do
  use Absinthe.Schema.Notation

  alias RedditWeb.Resolvers.User
  alias Reddit.Middlewares.Fields

  import_types(RedditWeb.Types.User)
  import_types(RedditWeb.Inputs.User)

  object :user_queries do
    field :me, :user do
      middleware(Reddit.Middlewares.Auth)
      middleware(Fields.map(:posts))
      resolve(&User.me/3)
    end
  end

  object :user_mutations do
    field :login, :user_response |> non_null do
      arg(:username, :string |> non_null)
      arg(:password, :string |> non_null)

      resolve(&User.login/3)
    end

    field :register, :user_response |> non_null do
      arg(:input, :create_user_input |> non_null)

      resolve(&User.register/3)
    end

    field :forgot_password, :boolean |> non_null do
      arg(:new_password, :string |> non_null)
      arg(:confirm_new_password, :string |> non_null)

      middleware(Reddit.Middlewares.Auth)
      resolve(&User.forgot_password/3)
    end
  end
end
