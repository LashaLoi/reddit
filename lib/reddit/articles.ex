defmodule Reddit.Articles do
  import Ecto.Query, warn: false

  alias Reddit.Repo
  alias Reddit.Articles.Post

  def list_posts, do: Repo.all(Post) |> Repo.preload(:user)

  def get_post(id), do: Repo.get(Post, id) |> Repo.preload(:user)

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def delete_post(%Post{} = post), do: Repo.delete(post)
  def delete_post(nil), do: nil
end
