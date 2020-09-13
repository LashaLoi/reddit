defmodule RedditWeb.Queries.Comment do
  use Absinthe.Schema.Notation

  alias RedditWeb.{Types, Resolvers}

  import_types(Types.Comment)

  object :comment_queries do
    field :comments, :comment |> list_of |> non_null do
      resolve(&Resolvers.Comment.comments/3)
    end
  end

  # object :comment_mutations do
  #   field :create_comment, :comment do
  #     {:ok, nil}
  #   end
  # end
end
