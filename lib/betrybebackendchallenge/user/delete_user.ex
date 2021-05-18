defmodule Betrybebackendchallenge.DeleteUser do
  alias Betrybebackendchallenge.{User, Repo}

  def run(%User{} = user) do
    case Repo.delete(user) do
      nil ->
        {:error,
         %{result: "Something went wrong with the server", status: :internal_server_error}}

      struct ->
        {:ok, struct}
    end
  end
end
