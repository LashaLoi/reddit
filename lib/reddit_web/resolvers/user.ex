defmodule RedditWeb.Resolvers.User do
  def register(_root, _args, _info) do
    {:ok, "register"}
  end

  def login(_root, _args, _info) do
    {:ok, "login"}
  end
end
