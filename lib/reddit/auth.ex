defmodule Reddit.Auth do
  import Ecto.Query, warn: false

  alias Reddit.Repo
  alias Reddit.Auth.User
  alias Reddit.Guardian

  @error_message "Incorrect username or password"

  def login(%{username: username, password: pass}) do
    Repo.get_by(User, username: username)
    |> set_token()
    |> check_password(pass)
  end

  def register(attrs \\ %{}) do
    {:ok, user} =
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()

    {:ok, set_token(user)}
  end

  def get_user!(id), do: Repo.get!(User, id)

  defp check_password(nil, _) do
    {:error, @error_message}
  end

  defp check_password(user, password) do
    case Comeonin.Bcrypt.checkpw(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, @error_message}
    end
  end

  defp set_token(nil), do: nil

  defp set_token(user) do
    {:ok, token, _claim} = Guardian.encode_and_sign(user)

    Map.put(user, :token, token)
  end
end
