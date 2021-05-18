defmodule Betrybebackendchallenge.Authorized do
  alias Betrybebackendchallenge.{Repo, User, Post}

  def run(post_id, {:ok, %User{} = user}) do
    Post
    |> Repo.get(post_id)
    |> Repo.preload(:user)
    |> check_if_user_is_authorized(user.id)
  end

  defp check_if_user_is_authorized(nil, _user_id) do
    {:error, %{result: "Post não encontrado", status: :bad_request}}
  end

  defp check_if_user_is_authorized(%Post{} = post, user_id) do
    if post.user_id == user_id do
      {:ok, post}
    else
      {:error, %{result: "Usuário não autorizado", status: :unauthorized}}
    end
  end
end
