defmodule Reddit.Auth do
  import Ecto.Query, warn: false

  alias Reddit.Repo
  alias Reddit.Auth.User
  alias Reddit.Guardian

  alias Comeonin.Bcrypt

  def get_user!(id), do: Repo.get!(User, id) |> Repo.preload(:posts)

  def login(%{username: username, password: pass}) do
    Repo.get_by(User, username: username)
    |> Repo.preload(:posts)
    |> set_token()
    |> check_password(pass)
  end

  def register(attrs \\ %{}) do
    case %User{}
         |> User.changeset(attrs)
         |> Repo.insert() do
      {:ok, user} ->
        {:ok, set_token(user)}

      {:error, changeset} ->
        {_, {message, _}} = hd(changeset.errors)

        {:error, message}
    end
  end

  @error_message "Incorrect username or password"

  defp check_password(nil, _), do: {:error, @error_message}

  defp check_password(user, password) do
    case Bcrypt.checkpw(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, @error_message}
    end
  end

  defp set_token(nil), do: nil

  defp set_token(user) do
    {:ok, token, _claim} = Guardian.encode_and_sign(user)

    IO.inspect(user)

    Map.put(user, :token, token)
  end
end
