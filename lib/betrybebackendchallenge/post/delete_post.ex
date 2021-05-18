defmodule Betrybebackendchallenge.DeletePost do
  @moduledoc """
  Delete a post
  """
  alias Betrybebackendchallenge.{Post, Repo}

  def run(%Post{} = post) do
    Repo.delete(post)
  end
end
