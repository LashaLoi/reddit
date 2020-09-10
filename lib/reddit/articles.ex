defmodule Reddit.Articles do
  import Ecto.Query, warn: false

  alias Reddit.Repo
  alias Reddit.Articles.Post
  alias Helpers.FormatData

  def list_posts(limit, offset) do
    Post
    |> limit(^limit)
    |> offset(^offset)
    |> Repo.all()
    |> Repo.preload(:user)
  end

  def list_posts, do: Repo.all(Post) |> Repo.preload(:user)

  def get_post(id), do: Repo.get(Post, id) |> Repo.preload(:user)

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
