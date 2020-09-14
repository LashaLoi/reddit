defmodule RedditWeb.Queries.Comment do
  use Absinthe.Schema.Notation

  alias RedditWeb.{Types, Resolvers, Inputs}

  import_types(Types.Comment)
  import_types(Inputs.Comment)

  object :comment_queries do
    field :comments, :comment |> list_of |> non_null do
      resolve(&Resolvers.Comment.comments/3)
    end

    field :comment, :comment do
      arg(:id, :id |> non_null)

      resolve(&Resolvers.Comment.get_comment/3)
    end
  end

  object :comment_mutations do
    field :create_comment, :comment do
      arg(:input, :create_comment_input |> non_null)

      resolve(&Resolvers.Comment.create_comment/3)
    end
  end
end
