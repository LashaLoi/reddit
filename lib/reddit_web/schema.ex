defmodule RedditWeb.Schema do
  use Absinthe.Schema

  alias RedditWeb.Queries.{User, Post, Comment}

  import_types(User)
  import_types(Post)
  import_types(Comment)

  query do
    import_fields(:user_queries)
    import_fields(:post_queries)
    import_fields(:comment_queries)
  end

  mutation do
    import_fields(:user_mutations)
    import_fields(:post_mutations)
  end

  subscription do
    import_fields(:post_subscriptions)
  end
end
