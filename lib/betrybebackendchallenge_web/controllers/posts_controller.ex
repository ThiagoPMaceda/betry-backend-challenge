defmodule BetrybebackendchallengeWeb.PostsController do
  use BetrybebackendchallengeWeb, :controller

  alias Betrybebackendchallenge.Blog.Post
  alias Betrybebackendchallenge.Blog
  alias Betrybebackendchallenge.User
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

  def index(conn, _) do
    Plug.current_token(conn)

    with posts <- Blog.list_posts_and_users() do
      conn
      |> put_status(:ok)
      |> render("index.json", posts: posts)
    end
  end

  def show(conn, %{"id" => _search, "q" => term}) when term != "" do
    with posts <- Blog.search_post_by_term(term) do
      conn
      |> put_status(:ok)
      |> render("index.json", posts: posts)
    end
  end

  def show(conn, %{"id" => _search, "q" => term}) when term == "" do
    with posts <- Blog.list_posts_and_users() do
      conn
      |> put_status(:ok)
      |> render("index.json", posts: posts)
    end
  end

  def show(conn, %{"id" => id}) when id != "search" do
    with {:ok, post} <- Blog.get_post!(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", post: post)
    end
  end

  def update(conn, %{"content" => content, "title" => title, "id" => post_id} = _params) do
    current_user = Plug.current_resource(conn)

    attrs_to_update = %{"title" => title, "content" => content}

    with {:ok, post} <- Blog.get_post_if_user_is_authorized(post_id, current_user) do
      with {:ok, updated_post} <- Blog.update_post(post, attrs_to_update) do
        conn
        |> put_status(:ok)
        |> render("update.json", updated_post: updated_post)
      end
    end
  end

  def update(_conn, %{"content" => _content, "id" => _post_id} = _params),
    do: {:error, %{result: "\"title\" is required", status: :bad_request}}

  def update(_conn, %{"title" => _title, "id" => _post_id} = _params),
    do: {:error, %{result: "\"content\" is required", status: :bad_request}}

  def delete(conn, %{"id" => id}) do
    current_user = Plug.current_resource(conn)

    with {:ok, post} <- Blog.get_post_if_user_is_authorized(id, current_user) do
      with {:ok, %Post{}} <- Blog.delete_post(post) do
        conn
        |> send_resp(201, "")
      end
    end
  end
end
