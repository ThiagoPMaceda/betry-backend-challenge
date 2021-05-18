defmodule Betrybebackendchallenge.ListPosts do
  import Ecto.Query, only: [from: 2]

  alias Betrybebackendchallenge.{Post, Repo}

  def run do
    query = from(Post, preload: :user)
    Repo.all(query)
  end
end
