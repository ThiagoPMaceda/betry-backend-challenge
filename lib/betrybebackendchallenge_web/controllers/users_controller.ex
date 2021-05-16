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

  def index(conn, _) do
    BetrybebackendchallengeWeb.Guardian.Plug.current_token(conn)

    with users <- Betrybebackendchallenge.Users.list_users() do
      conn
      |> put_status(:ok)
      |> render("index.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Betrybebackendchallenge.Users.get_user!(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end
end
