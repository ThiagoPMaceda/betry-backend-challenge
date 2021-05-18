defmodule Betrybebackendchallenge.ListUsers do
  @moduledoc """
  List all users
  """
  import Ecto.Query, only: [from: 1]

  alias Betrybebackendchallenge.{User, Repo}

  def run do
    query = from(User)
    Repo.all(query)
  end
end
