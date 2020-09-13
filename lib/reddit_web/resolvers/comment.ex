defmodule RedditWeb.Resolvers.Comment do
  alias Reddit.Comments

  def comments(_root, _args, _info) do
    {:ok, Comments.list_comments()}
  end
end
