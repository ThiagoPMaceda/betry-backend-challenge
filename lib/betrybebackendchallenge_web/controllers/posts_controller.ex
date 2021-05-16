defmodule BetrybebackendchallengeWeb.PostsController do
  use BetrybebackendchallengeWeb, :controller

  alias Betrybebackendchallenge.Blog.Post
  alias Betrybebackendchallenge.Blog
  alias Betrybebackendchallenge.Users.User
  alias BetrybebackendchallengeWeb.Guardian.Plug

  alias BetrybebackendchallengeWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    Plug.current_token(conn)

    with {:ok, %User{} = user} = Plug.current_resource(conn) do
      with {:ok, %Post{} = post} <- Blog.create_post(params, user.id) do
        conn
        |> put_status(:created)
        |> render("create.json", post: post)
      end
    end
  end
end
