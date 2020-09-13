defmodule Reddit.Repo.Migrations.AddUsernameToComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :username, :string
    end
  end
end
