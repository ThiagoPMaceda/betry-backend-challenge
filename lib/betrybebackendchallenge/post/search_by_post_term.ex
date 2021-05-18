defmodule Betrybebackendchallenge.SearchByPostTerm do
  import Ecto.Query

  alias Betrybebackendchallenge.{Post, Repo}

  def run(term) do
    Repo.all(
      from p in Post,
        where: ilike(p.title, ^"%#{term}%"),
        or_where: ilike(p.content, ^"%#{term}%")
    )
    |> Repo.preload(:user)
  end
end
