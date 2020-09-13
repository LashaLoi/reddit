defmodule Reddit.Auth do
  import Ecto.Query, warn: false

  alias Reddit.Repo
  alias Reddit.Auth.User
  alias Reddit.Guardian
  alias Reddit.Helpers.FormatData
  alias Comeonin.Bcrypt
  alias Reddit.Helpers.Utils

  def get_user!(id, fields) do
    fields = remove_token(fields)

    user_query =
      from u in User,
        where: u.id == ^id,
        order_by: [desc: :inserted_at],
        select: ^fields

    Utils.add_resource_if_exists(user_query, fields, :posts)
    |> Repo.one()
  end

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
        FormatData.format_error(changeset)
    end
  end

  def update_password(new_password, user_id) do
    case Repo.get!(User, user_id)
         |> Ecto.Changeset.change(password_hash: Bcrypt.hashpwsalt(new_password))
         |> Repo.update() do
      {:ok, _} -> true
      {:error, _} -> false
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

    Map.put(user, :token, token)
  end

  defp remove_token(params), do: Enum.filter(params, &(&1 != :token))
end
