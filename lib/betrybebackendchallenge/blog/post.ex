defmodule Betrybebackendchallenge.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Betrybebackendchallenge.Users.User

  @timestamps_opts [
    type: :utc_datetime,
    inserted_at: :published,
    updated_at: :updated,
    inserted_at_source: :published,
    updated_at_source: :updated
  ]

  @derive {Jason.Encoder, only: [:title, :content, :user_id] ++ [:id]}

  schema "posts" do
    field :content, :string
    field :title, :string
    field :user_id, :id

    belongs_to :users, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :user_id])
    |> validate_required([:title, :content, :user_id])
  end
end
