defmodule Betrybebackendchallenge.UserRepo do
  @moduledoc """
  The User context.
  """

  import Ecto.Query, warn: false
  alias Betrybebackendchallenge.Repo

  alias Betrybebackendchallenge.User

  def get_user_by_email!(email), do: Repo.get_by!(User, email: email)

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
