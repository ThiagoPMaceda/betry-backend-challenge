defmodule BetrybebackendchallengeWeb.UsersController do
  use BetrybebackendchallengeWeb, :controller

  alias Betrybebackendchallenge.{User, ListUsers, CreateUser, GetUser}
  alias BetrybebackendchallengeWeb.FallbackController
  alias BetrybebackendchallengeWeb.Guardian

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, user} <- CreateUser.run(params) do
      with {:ok, token, _} <- Guardian.encode_and_sign(user) do
        conn
        |> put_status(:created)
        |> render("create.json", token: token)
      end
    end
  end

  def index(conn, _) do
    with users <- ListUsers.run() do
      conn
      |> put_status(:ok)
      |> render("index.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- GetUser.run(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end
end
