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

%Post{
  title: "Transformers",
  description: "Cool robots you know",
  user_id: first_user.id
}
|> Repo.insert()

%Post{
  title: "Inseption",
  description: "I wanna sleep",
  user_id: first_user.id
}
|> Repo.insert()

%Post{
  title: "Star Wars",
  description: "I am your father",
  user_id: second_user.id
}
|> Repo.insert()
