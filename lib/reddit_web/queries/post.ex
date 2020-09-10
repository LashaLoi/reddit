defmodule RedditWeb.Queries.Post do
  use Absinthe.Schema.Notation

  alias RedditWeb.Resolvers.Post

  import_types(RedditWeb.Types.Post)
  import_types(RedditWeb.Inputs.Post)

  object :post_queries do
    field :posts, :post |> list_of do
      arg(:limit, :integer, default_value: nil)
      arg(:offset, :integer, default_value: nil)

      resolve(&Post.posts/3)
    end

    field :post, :post_response do
      arg(:id, :id |> non_null)

      resolve(&Post.post/3)
    end
  end

  object :post_mutations do
    field :create_post, :post_response do
      arg(:input, :create_post_input)

      middleware(Middlewares.Auth)
      resolve(&Post.create_post/3)
    end

    field :delete_post, :boolean |> non_null do
      arg(:id, :id |> non_null)

      middleware(Middlewares.Auth)
      resolve(&Post.delete_post/3)
    end
  end
end
