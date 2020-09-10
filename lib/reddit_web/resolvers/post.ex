defmodule RedditWeb.Resolvers.Post do
  alias Reddit.Articles
  alias Helpers.FormatResponse

  def posts(_root, _args, _info), do: {:ok, Articles.list_posts()}

  def post(_root, %{id: id}, _info) do
    case Articles.get_post(id) do
      nil -> FormatResponse.format("not able to get post with id: #{id}", :post)
      post -> FormatResponse.format(post, :post)
    end
  end

  def create_post(_root, %{input: input}, %{context: %{id: user_id}}) do
    case Map.put(input, :user_id, user_id) |> Articles.create_post() do
      {:ok, post} -> FormatResponse.format(post, :post)
      {:error, error_message} -> FormatResponse.format(error_message, :post)
    end
  end

  def create_post(_roor, _args, _info), do: FormatResponse.format("unauthorized user", :post)

  def delete_post(_root, _args, _info) do
    {:ok, nil}
  end
end
