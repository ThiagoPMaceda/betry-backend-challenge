defmodule BetrybebackendchallengeWeb.PostsController do
  use BetrybebackendchallengeWeb, :controller

  alias Betrybebackendchallenge.{
    Post,
    ListPosts,
    User,
    CreatePost,
    GetPost,
    UpdatePost,
    Authorized,
    SearchByPostTerm,
    DeletePost
  }

  alias BetrybebackendchallengeWeb.Guardian.Plug

  alias BetrybebackendchallengeWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} = Plug.current_resource(conn) do
      with {:ok, %Post{} = post} <- CreatePost.run(params, user.id) do
        conn
        |> put_status(:created)
        |> render("create.json", post: post)
      end
    end
  end

  def index(conn, _) do
    with posts <- ListPosts.run() do
      conn
      |> put_status(:ok)
      |> render("index.json", posts: posts)
    end
  end

  def show(conn, %{"id" => _search, "q" => term}) when term != "" do
    with posts <- SearchByPostTerm.run(term) do
      conn
      |> put_status(:ok)
      |> render("index.json", posts: posts)
    end
  end

  def show(conn, %{"id" => _search, "q" => term}) when term == "" do
    with posts <- ListPosts.run() do
      conn
      |> put_status(:ok)
      |> render("index.json", posts: posts)
    end
  end

  def show(conn, %{"id" => id}) when id != "search" do
    with {:ok, post} <- GetPost.run(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", post: post)
    end
  end

  def update(conn, %{"content" => content, "title" => title, "id" => post_id} = _params) do
    current_user = Plug.current_resource(conn)

    attrs_to_update = %{"title" => title, "content" => content}

    with {:ok, post} <- Authorized.run(post_id, current_user) do
      with {:ok, updated_post} <- UpdatePost.run(post, attrs_to_update) do
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

    with {:ok, post} <- Authorized.run(id, current_user) do
      with {:ok, %Post{}} <- DeletePost.run(post) do
        conn
        |> send_resp(201, "")
      end
    end
  end
end
