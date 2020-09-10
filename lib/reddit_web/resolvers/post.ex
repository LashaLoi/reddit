defmodule RedditWeb.Resolvers.Post do
  alias Reddit.Articles

  def posts(_root, _args, _info) do
    {:ok, nil}
  end

  def post(_root, _args, _info) do
    {:ok, nil}
  end

  def create_post(_root, %{input: input}, _info) do
    case Articles.create_post(input) do
      {:ok, post} -> {:ok, %{post: post, error_message: nil}}
      {:error, error_message} -> {:ok, %{post: nil, error_message: error_message}}
    end
  end

  def delete_post(_root, _args, _info) do
    {:ok, nil}
  end
end
