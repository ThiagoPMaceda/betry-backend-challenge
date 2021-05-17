defmodule Betrybebackendchallenge.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Betrybebackendchallenge.Repo

  alias Betrybebackendchallenge.Blog.Post
  alias Betrybebackendchallenge.Users.User

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  def list_posts_and_users do
    Post
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id) do
    Post
    |> Repo.get(id)
    |> Repo.preload(:user)
    |> handle_get_post()
  end

  defp handle_get_post(nil),
    do: {:error, %{result: "Post não encontrado", status: :bad_request}}

  defp handle_get_post(post), do: {:ok, post}

  def get_post_if_user_is_authorized(post_id, {:ok, %User{} = user}) do
    Post
    |> Repo.get(post_id)
    |> Repo.preload(:user)
    |> check_if_user_is_authorized(user.id)
  end

  defp check_if_user_is_authorized(%Post{} = post, user_id) do
    if post.user_id == user_id do
      {:ok, post}
    else
      {:error, %{result: "Usuário não autorizado", status: :unauthorized}}
    end
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs, user_id) do
    add_id_to_attrs =
      attrs
      |> Map.put("user_id", user_id)

    %Post{}
    |> Post.changeset(add_id_to_attrs)
    |> Repo.insert()
    |> handle_create_post()
  end

  defp handle_create_post(
         {:error,
          %Ecto.Changeset{
            errors: [
              title: {"can't be blank", [validation: :required]}
            ]
          }}
       ) do
    {:error, %{result: "\"title\" is required", status: :bad_request}}
  end

  defp handle_create_post(
         {:error,
          %Ecto.Changeset{
            errors: [
              content: {"can't be blank", [validation: :required]}
            ]
          }}
       ) do
    {:error, %{result: "\"content\" is required", status: :bad_request}}
  end

  defp handle_create_post({:ok, %Post{}} = result), do: result

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def check_if_contains_all_params(params) do
    content = Map.has_key?(params, "content")
    title = Map.has_key?(params, "title")

    with false <- content == false do
      {:error, %{result: "\"content\" is required", status: :bad_request}}
    end

    with false <- title == false do
      {:error, %{result: "\"title\" is required", status: :bad_request}}
    end
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
