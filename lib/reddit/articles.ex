defmodule Reddit.Articles do
  import Ecto.Query, warn: false

  alias Reddit.Repo
  alias Reddit.Articles.Post
  alias Reddit.Helpers.FormatData
  alias Reddit.Helpers.Utils

  def list_posts(fields, limit \\ nil, offset \\ nil, title \\ nil) do
    posts_query =
      from p in Post,
        where: like(p.title, ^"%#{title}%"),
        limit: ^limit,
        offset: ^offset,
        order_by: [desc: :inserted_at],
        select: ^fields

    Utils.add_resource_if_exists(posts_query, fields, :user)
    |> Repo.all()
  end

  def get_post(id, fields) do
    post_query =
      from p in Post,
        where: p.id == ^id,
        order_by: [desc: :inserted_at],
        select: ^fields

    Utils.add_resource_if_exists(post_query, fields, :user)
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
end
