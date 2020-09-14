alias Reddit.Repo
alias Reddit.Auth.User
alias Reddit.Articles.Post
alias Reddit.Comments.Comment

# Users
{:ok, first_user} =
  %User{
    username: "sideswipeloi",
    email: "sideswipe@gmail.com",
    password_hash: Comeonin.Bcrypt.hashpwsalt("password")
  }
  |> Repo.insert()

{:ok, second_user} =
  %User{
    username: "alex",
    email: "alexloi@gmail.com",
    password_hash: Comeonin.Bcrypt.hashpwsalt("password")
  }
  |> Repo.insert()

# Posts
Enum.each(
  1..10,
  fn ->
    {:ok, post} =
      %Post{
        title: FakerElixir.Name.title(),
        description: FakerElixir.Lorem.sentence(),
        user_id: first_user.id
      }
      |> Repo.insert()

    # Comments
    Enum.each(1..4, fn _ ->
      %Comment{
        text: FakerElixir.Lorem.sentence(),
        post_id: post.id,
        username: first_user.username
      }
      |> Repo.insert()
    end)
  end
)

Enum.each(
  1..5,
  fn ->
    {:ok, post} =
      %Post{
        title: FakerElixir.Name.title(),
        description: FakerElixir.Lorem.sentence(),
        user_id: second_user.id
      }
      |> Repo.insert()

    # Comments
    Enum.each(1..4, fn _ ->
      %Comment{
        text: FakerElixir.Lorem.sentence(),
        post_id: post.id,
        username: second_user.username
      }
      |> Repo.insert()
    end)
  end
)
