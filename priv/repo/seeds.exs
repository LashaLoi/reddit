alias Reddit.Repo
alias Reddit.Auth.User
alias Reddit.Articles.Post

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
  1..20,
  fn _ ->
    %Post{
      title: FakerElixir.Name.title(),
      description: FakerElixir.Lorem.sentence(),
      user_id: first_user.id
    }
    |> Repo.insert()
  end
)

Enum.each(
  1..15,
  fn _ ->
    %Post{
      title: FakerElixir.Name.title(),
      description: FakerElixir.Lorem.sentence(),
      user_id: second_user.id
    }
    |> Repo.insert()
  end
)
