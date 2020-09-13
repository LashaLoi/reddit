defmodule RedditWeb.Subscriptions.Post do
  def post_added(post, _, _), do: {:ok, post}

  def post_deleted(post, _, _), do: {:ok, post}
end
