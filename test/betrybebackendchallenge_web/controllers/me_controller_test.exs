defmodule BetrybebackendchallengeWeb.MeControllerTest do
  use BetrybebackendchallengeWeb.ConnCase, async: true
  use ExUnit.Case
  import BetrybebackendchallengeWeb.Guardian

  import BetrybebackendchallengeWeb.UserAuth

  setup [:create_user]

  setup %{conn: conn} do
    conn = authenticate(conn)
    %{conn: conn}
  end

  describe "delete/2" do
    test "returns 201 when user is deleted", %{conn: conn} do
      R

      conn
      |> post(Routes.users_path(conn, :create, params))
      |> json_response(:created)

      IO.inspect(response(conn, 201))
    end
  end
end
