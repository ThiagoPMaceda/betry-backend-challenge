defmodule BetrybebackendchallengeWeb.UserAuth do
  import Blog.Factory
  import Plug.Conn

  alias BetrybebackendchallengeWeb.Guardian

  def authenticate(conn, user \\ insert(:user)) do
    {:ok, token, _} = Guardian.encode_and_sign(user)

    put_req_header(conn, "authorization", "Bearer " <> token)
  end
end
