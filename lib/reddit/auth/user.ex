defmodule Reddit.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @required_fields [:username, :password, :email]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ [:password_hash])
    |> validate_required(@required_fields)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        change(changeset, password_hash: Comeonin.Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
