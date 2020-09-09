defmodule Reddit.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash, :email])
    |> validate_required([:username, :password_hash, :email])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
