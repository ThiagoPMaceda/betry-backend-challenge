defmodule Betrybebackendchallenge.CreateUser do
  @moduledoc """
  Create an user
  """
  alias Betrybebackendchallenge.{User, Repo}

  def run(attrs \\ %{}) do
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
              displayname: {"can't be blank", [validation: :required]}
            ]
          }}
       ) do
    {:error, %{result: "\"displayname\" is required", status: :bad_request}}
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
end
