defmodule Betrybebackendchallenge.Post do
  @moduledoc """
  Post schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Betrybebackendchallenge.User

  @timestamps_opts [
    type: :utc_datetime,
    inserted_at: :published,
    updated_at: :updated,
    inserted_at_source: :published,
    updated_at_source: :updated
  ]

  @derive {Jason.Encoder, only: [:title, :content, :user_id, :updated, :published, :user, :id]}

  schema "posts" do
    field :content, :string
    field :title, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :user_id])
    |> validate_required([:title, :content, :user_id])
  end
end
