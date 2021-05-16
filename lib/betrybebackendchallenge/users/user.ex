defmodule Betrybebackendchallenge.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Betrybebackendchallenge.Blog.Post

  @required_params [:displayname, :email, :image]
  @derive {Jason.Encoder, only: [:id] ++ @required_params}

  schema "users" do
    field :displayname, :string
    field :email, :string
    field :image, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :posts, Post

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
    |> hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp hash_password(changeset), do: changeset
end
