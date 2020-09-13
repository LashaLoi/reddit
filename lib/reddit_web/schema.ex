defmodule RedditWeb.Schema do
  use Absinthe.Schema

  import_types(RedditWeb.Queries.User)
  import_types(RedditWeb.Queries.Post)

  query do
    import_fields(:user_queries)
    import_fields(:post_queries)
  end

  mutation do
    import_fields(:user_mutations)
    import_fields(:post_mutations)
  end

  subscription do
    import_fields(:post_subscriptions)
  end
end
