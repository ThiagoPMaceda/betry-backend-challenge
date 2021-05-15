defmodule BetrybebackendchallengeWeb.UsersController do
  use BetrybebackendchallengeWeb, :controller

  alias Betrybebackendchallenge.Users.User
  alias BetrybebackendchallengeWeb.FallbackController
  alias BetrybebackendchallengeWeb.Guardian

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Betrybebackendchallenge.Users.create_user(params) do
      {:ok, token, _} = Guardian.encode_and_sign(user)

      conn
      |> put_status(:created)
      |> render("create.json", token: token)
    end
  end
end
