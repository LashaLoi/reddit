defmodule RedditWeb.Queries.User do
  use Absinthe.Schema.Notation

  alias RedditWeb.{Resolvers, Types, Inputs}
  alias Reddit.Middlewares.{Fields, Auth}

  import_types(Types.User)
  import_types(Inputs.User)

  object :user_queries do
    @desc "Get current user"
    field :me, :user do
      middleware(Auth)
      middleware(Fields.map(:posts))
      resolve(&Resolvers.User.me/3)
    end
  end

  object :user_mutations do
    @desc "Sign in to application"
    field :login, :user_response |> non_null do
      arg(:username, :string |> non_null)
      arg(:password, :string |> non_null)

      resolve(&Resolvers.User.login/3)
    end

    @desc "Sign up in application"
    field :register, :user_response |> non_null do
      arg(:input, :create_user_input |> non_null)

      resolve(&Resolvers.User.register/3)
    end

    @desc "Update user password"
    field :forgot_password, :boolean |> non_null do
      arg(:new_password, :string |> non_null)
      arg(:confirm_new_password, :string |> non_null)

      middleware(Auth)
      resolve(&Resolvers.User.forgot_password/3)
    end
  end
end
