defmodule BetrybebackendchallengeWeb.LoginControllerTest do
  use BetrybebackendchallengeWeb.ConnCase, async: true

  describe "create/2" do
    test "returns 200 when user is found", %{conn: conn} do
      post(conn, "/api/user", %{
        "displayname" => "John Doee",
        "email" => "john@gmail.com",
        "password" => "123456",
        "image" =>
          "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
      })

      conn =
        post(conn, "/api/login", %{
          "email" => "john@gmail.com",
          "password" => "123456"
        })

      assert %{"token" => _} = json_response(conn, 200)
    end

    test "returns 400 when email is not sent in the body", %{conn: conn} do
      conn =
        post(conn, "/api/login", %{
          "password" => "123456"
        })

      assert %{"message" => "\"email\" is required"} = json_response(conn, 400)
    end

    test "returns 400 when email is empty", %{conn: conn} do
      conn =
        post(conn, "/api/login", %{
          "email" => "",
          "password" => "123456"
        })

      assert %{"message" => "\"email\" is not allowed to be empty"} = json_response(conn, 400)
    end

    test "returns 400 when password is not sent in the body", %{conn: conn} do
      conn =
        post(conn, "/api/login", %{
          "email" => "john@gmail.com"
        })

      assert %{"message" => "\"password\" is required"} = json_response(conn, 400)
    end

    test "returns 400 when password is empty", %{conn: conn} do
      conn =
        post(conn, "/api/login", %{
          "email" => "john@gmail.com",
          "password" => ""
        })

      assert %{"message" => "\"password\" is not allowed to be empty"} = json_response(conn, 400)
    end
  end
end
