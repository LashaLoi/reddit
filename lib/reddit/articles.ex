defmodule Reddit.Articles do
  import Ecto.Query, warn: false

  alias Reddit.Repo
  alias Reddit.Articles.Post
  alias Reddit.Helpers.FormatData

  def list_posts(fields, limit \\ nil, offset \\ nil, title \\ nil) do
    posts_query =
      from p in Post,
        where: like(p.title, ^"%#{title}%"),
        limit: ^limit,
        offset: ^offset,
        order_by: [desc: :inserted_at],
        select: ^fields

    get_user_if_exist(posts_query, fields)
    |> Repo.all()
  end

  def get_post(id, fields) do
    post_query =
      from p in Post,
        where: p.id == ^id,
        order_by: [desc: :inserted_at],
        select: ^fields

    get_user_if_exist(post_query, fields)
    |> Repo.one()
  end

  def get_post(id), do: Repo.get!(Post, id)

  def create_post(attrs \\ %{}) do
    case %Post{}
         |> Post.changeset(attrs)
         |> Repo.insert() do
      {:ok, post} ->
        {:ok, post}

      {:error, changeset} ->
        FormatData.format_error(changeset)
    end
  end

  def delete_post(%Post{} = post), do: Repo.delete(post)
  def delete_post(nil), do: nil

  defp get_user_if_exist(query, params) do
    case Keyword.has_key?(params, :user) do
      true ->
        from(p in query,
          join: u in assoc(p, :user),
          preload: [user: u]
        )

      false ->
        query
    end
  end
end
