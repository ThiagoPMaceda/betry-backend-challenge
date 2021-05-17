defmodule BetrybebackendchallengeWeb.LoginController do
  use BetrybebackendchallengeWeb, :controller

  alias Betrybebackendchallenge.Users.User
  alias BetrybebackendchallengeWeb.FallbackController
  alias BetrybebackendchallengeWeb.Guardian

  action_fallback FallbackController

  def create(conn, %{"email" => email, "password" => _}) when email == "",
    do:
      FallbackController.call(
        conn,
        {:error, %{result: "\"email\" is not allowed to be empty", status: :bad_request}}
      )

  def create(conn, %{"email" => _, "password" => password}) when password == "",
    do:
      FallbackController.call(
        conn,
        {:error, %{result: "\"email\" is not allowed to be empty", status: :bad_request}}
      )

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, %User{} = user} <-
           Betrybebackendchallenge.Users.get_user_by_email_and_password(email, password) do
      {:ok, token, _} = Guardian.encode_and_sign(user)

      conn
      |> put_status(:ok)
      |> render("login.json", token: token)
    end
  end

  def create(conn, %{"password" => _password}) do
    result = "\"email\" is required"
    status = :bad_request
    error_struct = {:error, %{result: result, status: status}}
    FallbackController.call(conn, error_struct)
  end

  def create(conn, %{"email" => _email}) do
    result = "\"password\" is required"
    status = :bad_request
    error_struct = {:error, %{result: result, status: status}}
    FallbackController.call(conn, error_struct)
  end
end
