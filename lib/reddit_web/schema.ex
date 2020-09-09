defmodule RedditWeb.Schema do
  use Absinthe.Schema

  import_types(RedditWeb.Queries.User)

  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end
end
