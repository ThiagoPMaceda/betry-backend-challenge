defmodule BetrybebackendchallengeWeb.MeController do
  use BetrybebackendchallengeWeb, :controller

  alias BetrybebackendchallengeWeb.Guardian
  alias Betrybebackendchallenge.Users.User
  alias BetrybebackendchallengeWeb.FallbackController

  action_fallback FallbackController

  def delete(conn, _) do
    with {:ok, %User{} = user} <- BetrybebackendchallengeWeb.Guardian.Plug.current_resource(conn) do
      with {:ok, _} <- Betrybebackendchallenge.Users.delete_user(user) do
        conn
        |> send_resp(:no_content, "")
      end
    end
  end
end
