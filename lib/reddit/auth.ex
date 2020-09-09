defmodule Reddit.Auth do
  import Ecto.Query, warn: false

  alias Reddit.Repo
  alias Reddit.Auth.User

  def login(%{username: username, password: pass}) do
    Repo.get_by(User, username: username) |> check_password(pass)
  end

  def register(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  defp check_password(nil, _) do
    {:error, "Unable to find user with username"}
  end

  defp check_password(user, password) do
    case Comeonin.Bcrypt.checkpw(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, "Incorrect username or password"}
    end
  end
end
