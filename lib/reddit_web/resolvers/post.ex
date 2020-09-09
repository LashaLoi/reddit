defmodule RedditWeb.Resolvers.Post do
  # alias Reddit.Articles

  def posts(_root, _args, _info) do
    {:ok, nil}
  end

  def post(_root, _args, _info) do
    {:ok, nil}
  end

  def create_post(_root, _args, _info) do
    {:ok, nil}
  end

  def delete_post(_root, _args, _info) do
    {:ok, nil}
  end
end
