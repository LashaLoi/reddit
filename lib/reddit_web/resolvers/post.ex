defmodule RedditWeb.Resolvers.Post do
  alias Reddit.Articles
  alias Helpers.FormatData

  def posts(_root, %{limit: limit, offset: offset}, _info) do
    {:ok, Articles.list_posts(limit, offset)}
  end

  def posts(_root, _args, _info), do: {:ok, Articles.list_posts()}

  def post(_root, %{id: id}, _info) do
    case Articles.get_post(id) do
      nil -> FormatData.format_response("not able to get post with id: #{id}", :post)
      post -> FormatData.format_response(post, :post)
    end
  end

  def create_post(_root, %{input: input}, %{context: %{id: user_id}}) do
    case Map.put(input, :user_id, user_id) |> Articles.create_post() do
      {:ok, post} -> FormatData.format_response(post, :post)
      {:error, error_message} -> FormatData.format_response(error_message, :post)
    end
  end

  def delete_post(_root, %{id: id}, _info) do
    with post <- Articles.get_post(id),
         {:ok, _} <- Articles.delete_post(post) do
      {:ok, true}
    else
      _ -> {:ok, false}
    end
  end
end
