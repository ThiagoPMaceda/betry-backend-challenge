defmodule BetrybebackendchallengeWeb.MeController do
  use BetrybebackendchallengeWeb, :controller

  alias BetrybebackendchallengeWeb.Guardian.Plug
  alias Betrybebackendchallenge.{User, DeleteUser}
  alias BetrybebackendchallengeWeb.FallbackController

  action_fallback FallbackController

  def delete(conn, _) do
    with {:ok, %User{} = user} <- Plug.current_resource(conn) do
      with {:ok, _} <- DeleteUser.run(user) do
        conn
        |> send_resp(:no_content, "")
      end
    end
  end
end
