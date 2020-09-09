defmodule Reddit.Auth.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    has_many :posts, Reddit.Articles.Post

    timestamps()
  end

  @required_fields [:username, :password, :email]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ [:password_hash])
    |> validate_required(@required_fields)
    |> validate_length(:username, min: 3, message: "to short username")
    |> unique_constraint(:username, message: "username already been taken")
    |> unique_constraint(:email, message: "email already been taken")
    |> validate_format(:email, ~r/@/, message: "not valid email")
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        change(changeset, password_hash: Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
