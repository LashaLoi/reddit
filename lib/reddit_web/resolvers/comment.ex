defmodule RedditWeb.Resolvers.Comment do
  alias Reddit.Comments

  def comments(_root, _args, _info) do
    {:ok, Comments.list_comments()}
  end

  def get_comment(_root, %{id: id}, _info) do
    {:ok, Comments.get_comment!(id)}
  end

  def create_comment(_root, _params, _info) do
    {:ok, nil}
  end
end
