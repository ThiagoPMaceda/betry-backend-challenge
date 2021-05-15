defmodule Betrybebackendchallenge.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :displayname, :string
      add :email, :string
      add :password, :string, virtual: true
      add :password_hash, :string
      add :image, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
