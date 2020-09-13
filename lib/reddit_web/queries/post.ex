defmodule RedditWeb.Queries.Post do
  use Absinthe.Schema.Notation

  alias RedditWeb.Resolvers.Post
  alias RedditWeb.Subscriptions
  alias Reddit.Middlewares.Fields

  import_types(RedditWeb.Types.Post)
  import_types(RedditWeb.Inputs.Post)

  object :post_queries do
    @desc "Get all posts"
    field :posts, :post |> list_of |> non_null do
      arg(:limit, :integer, default_value: nil)
      arg(:offset, :integer, default_value: nil)
      arg(:title, :string, default_value: nil)

      middleware(Fields.map(:user))
      resolve(&Post.posts/3)
    end

    @desc "Get post by id"
    field :post, :post_response |> non_null do
      arg(:id, :id |> non_null)

      middleware(Fields.map(:user))
      resolve(&Post.post/3)
    end
  end

  object :post_mutations do
    @desc "Create post with create_post_input input"
    field :create_post, :post_response |> non_null do
      arg(:input, :create_post_input)

      middleware(Reddit.Middlewares.Auth)
      resolve(&Post.create_post/3)
    end

    @desc "Delete post by id"
    field :delete_post, :boolean |> non_null do
      arg(:id, :id |> non_null)

      middleware(Reddit.Middlewares.Auth)
      resolve(&Post.delete_post/3)
    end
  end

  object :post_subscriptions do
    @desc "Subscribe on post_created mutation"
    field :post_created, :post do
      config(Subscriptions.Utils.set_topic())

      resolve(&Subscriptions.Post.post_added/3)
    end

    @desc "Subscribe on post_deleted mutation"
    field :post_deleted, :post do
      config(Subscriptions.Utils.set_topic())

      resolve(&Subscriptions.Post.post_deleted/3)
    end
  end
end
