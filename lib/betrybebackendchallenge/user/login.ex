defmodule Betrybebackendchallenge.Login do
  @moduledoc """
  User login module
  """
  alias Betrybebackendchallenge.{User, Repo}

  def run(email, password) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> verify_password(user, password)
      nil -> {:error, :email_or_password_invalid}
    end
  end

  def run(_) do
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
