defmodule Reddit.Articles.Post do
  use Ecto.Schema

  import Ecto.Changeset

  schema "posts" do
    field :description, :string
    field :title, :string

    belongs_to :user, Reddit.Auth.User
    has_many :comments, Reddit.Comments.Comment

    timestamps()
  end

  @required_fields [:title, :description, :user_id]
  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:title, min: 3, message: "to short title")
    |> validate_length(:description, min: 3, message: "to short description")
  end
end
