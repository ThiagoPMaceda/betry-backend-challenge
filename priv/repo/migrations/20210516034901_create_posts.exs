defmodule Betrybebackendchallenge.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :updated, :utc_datetime
      add :published, :utc_datetime

    end

    create index(:posts, [:user_id])
  end
end
