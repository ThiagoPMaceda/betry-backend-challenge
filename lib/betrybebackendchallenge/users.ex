defmodule Betrybebackendchallenge.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Betrybebackendchallenge.Repo

  alias Betrybebackendchallenge.Users.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id) do
    case Repo.get(User, id) do
      nil -> {:error, %{result: "Usuário não existe", status: :not_found}}
      user -> {:ok, user}
    end
  end

  def get_user_by_email!(email), do: Repo.get_by!(User, email: email)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
    |> handle_create_user()
  end

  defp handle_create_user(
         {:error,
          %Ecto.Changeset{
            errors: [email: {_, [constraint: :unique, constraint_name: "users_email_index"]}]
          }}
       ) do
    {:error, %{result: "Usuário já existe", status: :conflict}}
  end

  defp handle_create_user(
         {:error,
          %Ecto.Changeset{
            errors: [email: {"\"email\" must be a valid email", [validation: :format]}]
          }}
       ) do
    {:error, %{result: "\"email\" must be a valid email", status: :bad_request}}
  end

  defp handle_create_user(
         {:error,
          %Ecto.Changeset{
            errors: [
              displayname:
                {"\"displayname\" length must be at least 8 characters long",
                 [count: 8, validation: :length, kind: :min, type: :string]}
            ]
          }}
       ) do
    {:error,
     %{result: "\"displayname\" length must be at least 8 characters long", status: :bad_request}}
  end

  defp handle_create_user(
         {:error,
          %Ecto.Changeset{
            errors: [
              email: {"can't be blank", [validation: :required]}
            ]
          }}
       ) do
    {:error, %{result: "\"email\" is required", status: :bad_request}}
  end

  defp handle_create_user(
         {:error,
          %Ecto.Changeset{
            errors: [
              password:
                {"\"password\" length must be at least 6 characters long",
                 [count: 6, validation: :length, kind: :min, type: :string]}
            ]
          }}
       ) do
    {:error,
     %{result: "\"password\" length must be at least 6 characters long", status: :bad_request}}
  end

  defp handle_create_user(
         {:error,
          %Ecto.Changeset{
            errors: [
              password: {"can't be blank", [validation: :required]}
            ]
          }}
       ) do
    {:error, %{result: "\"password\" is required", status: :bad_request}}
  end

  defp handle_create_user({:error, result}), do: {:error, %{result: result, status: :bad_request}}

  defp handle_create_user({:ok, %User{}} = result), do: result

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    case Repo.delete(user) do
      nil ->
        {:error,
         %{result: "Something went wrong with the server", status: :internal_server_error}}

      struct ->
        {:ok, struct}
    end
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def get_user_by_email_and_password(email, password) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> verify_password(user, password)
      nil -> {:error, :email_or_password_invalid}
    end
  end

  def get_user_by_email_and_password(_) do
    {:error, %{result: "\"email\" is required", status: :bad_request}}
  end

  defp verify_password(user, password) do
    if Bcrypt.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :email_or_password_invalid}
    end
  end
end
