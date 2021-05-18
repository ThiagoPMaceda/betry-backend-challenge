defmodule Betrybebackendchallenge.GetPost do
  @moduledoc """
  Get a post by id
  """
  alias Betrybebackendchallenge.{Repo, Post}

  def run(id) do
    Post
    |> Repo.get(id)
    |> Repo.preload(:user)
    |> handle_get_post()
  end

  defp handle_get_post(nil),
    do: {:error, %{result: "Post não encontrado", status: :bad_request}}

  defp handle_get_post(post), do: {:ok, post}
end
