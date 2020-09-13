defmodule Reddit.Comments.Comment do
  use Ecto.Schema

  import Ecto.Changeset

  schema "comments" do
    field :text, :string
    field :username, :string

    belongs_to :post, Reddit.Articles.Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :username])
    |> validate_required([:text, :username])
  end
end
