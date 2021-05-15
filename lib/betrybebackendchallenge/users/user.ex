defmodule Betrybebackendchallenge.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :displayname, :string
    field :email, :string
    field :image, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:displayname, :email, :password, :image])
    |> validate_required([:displayname, :email, :password, :image])
    |> validate_length(:displayname,
      min: 8,
      message: "\"displayname\" length must be at least 8 characters long"
    )
    |> validate_length(:password,
      min: 6,
      message: "\"password\" length must be at least 6 characters long"
    )
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/, message: "\"email\" must be a valid email")
    |> unique_constraint(:email, message: "Usuário já existe")
  end
end
