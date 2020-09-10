defmodule RedditWeb.Resolvers.Post do
  alias Reddit.Articles

  def posts(_root, _args, _info) do
    {:ok, nil}
  end

  def post(_root, %{id: id}, _info) do
    case Articles.get_post(id) do
      nil -> {:ok, %{post: nil, error_message: "not able to get post with id: #{id}"}}
      post -> {:ok, %{post: post, error_message: nil}}
    end
  end

  def create_post(_root, %{input: input}, %{context: %{id: user_id}}) do
    case Map.put(input, :user_id, user_id) |> Articles.create_post() do
      {:ok, post} -> {:ok, %{post: post, error_message: nil}}
      {:error, error_message} -> {:ok, %{post: nil, error_message: error_message}}
    end
  end

  def create_post(_roor, _args, _info) do
    {:ok, %{post: nil, error_message: "unauthorized user"}}
  end

  def delete_post(_root, _args, _info) do
    {:ok, nil}
  end
end
