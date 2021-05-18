defmodule Betrybebackendchallenge.GetUser do
  alias Betrybebackendchallenge.{User, Repo}

  def run(id) do
    case Repo.get(User, id) do
      nil -> {:error, %{result: "Usuário não existe", status: :not_found}}
      user -> {:ok, user}
    end
  end
end
