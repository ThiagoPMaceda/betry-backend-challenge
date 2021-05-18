defmodule Betrybebackendchallenge.CreatePost do
  @moduledoc """
  Create a post
  """
  alias Betrybebackendchallenge.{Post, Repo}

  def run(attrs, user_id) do
    add_id_to_attrs =
      attrs
      |> Map.put("user_id", user_id)

    %Post{}
    |> Post.changeset(add_id_to_attrs)
    |> Repo.insert()
    |> handle_create_post()
  end

  defp handle_create_post(
         {:error,
          %Ecto.Changeset{
            errors: [
              title: {"can't be blank", [validation: :required]}
            ]
          }}
       ) do
    {:error, %{result: "\"title\" is required", status: :bad_request}}
  end

  defp handle_create_post(
         {:error,
          %Ecto.Changeset{
            errors: [
              content: {"can't be blank", [validation: :required]}
            ]
          }}
       ) do
    {:error, %{result: "\"content\" is required", status: :bad_request}}
  end

  defp handle_create_post({:ok, %Post{}} = result), do: result
end
