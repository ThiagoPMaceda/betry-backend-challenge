defmodule Betrybebackendchallenge.GetUser do
  @moduledoc """
  Get a user by id
  """
  alias Betrybebackendchallenge.{User, Repo}

  def run(id) do
    case Repo.get(User, id) do
      nil -> {:error, %{result: "Usuário não existe", status: :not_found}}
      user -> {:ok, user}
    end
  end
end
