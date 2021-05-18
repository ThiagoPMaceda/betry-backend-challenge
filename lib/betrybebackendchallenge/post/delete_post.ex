defmodule Betrybebackendchallenge.DeletePost do
  alias Betrybebackendchallenge.{Post, Repo}

  def run(%Post{} = post) do
    Repo.delete(post)
  end
end
