defmodule Betrybebackendchallenge.UpdatePost do
  alias Betrybebackendchallenge.{Repo, Post}

  def run(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end
end
