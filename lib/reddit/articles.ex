defmodule Reddit.Articles do
  import Ecto.Query, warn: false

  alias Reddit.Repo
  alias Reddit.Articles.Post
  alias Helpers.FormatData

  def list_posts(fields, limit \\ nil, offset \\ nil) do
    posts_query =
      from p in Post,
        limit: ^limit,
        offset: ^offset,
        join: u in assoc(p, :user),
        preload: [user: u],
        select: ^fields

    Repo.all(posts_query)
  end

  def get_post(id, fields) do
    post_query =
      from p in Post,
        where: p.id == ^id,
        join: u in assoc(p, :user),
        preload: [user: u],
        select: ^fields

    Repo.one(post_query)
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
end
