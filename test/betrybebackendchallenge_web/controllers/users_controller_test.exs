defmodule BetrybebackendchallengeWeb.UsersControllerTest do
  use BetrybebackendchallengeWeb.ConnCase, async: true

  describe "create/2" do
    test "returns 200 when user fills all data correctly", %{conn: conn} do
      conn =
        post(conn, "/api/user", %{
          "displayname" => "John Doee",
          "email" => "john@gmail.com",
          "password" => "123456",
          "image" =>
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
        })

      assert %{"token" => _} = json_response(conn, 201)
    end

    test "returns 400 when displayname is not filled", %{conn: conn} do
      conn =
        post(conn, "/api/user", %{
          "email" => "john@gmail.com",
          "password" => "123456",
          "image" =>
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
        })

      assert %{"message" => "\"displayname\" is required"} = json_response(conn, 400)
    end

    test "returns 400 when displayname contains less than 8 characters", %{conn: conn} do
      conn =
        post(conn, "/api/user", %{
          "displayname" => "Johndoe",
          "email" => "john@gmail.com",
          "password" => "123456",
          "image" =>
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
        })

      assert %{"message" => "\"displayname\" length must be at least 8 characters long"} =
               json_response(conn, 400)
    end

    test "returns 400 when email is not valid", %{conn: conn} do
      conn =
        post(conn, "/api/user", %{
          "displayname" => "Johndoee",
          "email" => "john",
          "password" => "123456",
          "image" =>
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
        })

      assert %{"message" => "\"email\" must be a valid email"} = json_response(conn, 400)
    end

    test "returns 400 when email is not filled", %{conn: conn} do
      conn =
        post(conn, "/api/user", %{
          "displayname" => "John Doee",
          "password" => "123456",
          "image" =>
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
        })

      assert %{"message" => "\"email\" is required"} = json_response(conn, 400)
    end

    test "returns 400 when password is not filled", %{conn: conn} do
      conn =
        post(conn, "/api/user", %{
          "displayname" => "John Doee",
          "email" => "john@gmail.com",
          "image" =>
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
        })

      assert %{"message" => "\"password\" is required"} = json_response(conn, 400)
    end

    test "returns 400 when password has less than 6 characters", %{conn: conn} do
      conn =
        post(conn, "/api/user", %{
          "displayname" => "John Doee",
          "password" => "1234",
          "email" => "john@gmail.com",
          "image" =>
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
        })

      assert %{"message" => "\"password\" length must be at least 6 characters long"} =
               json_response(conn, 400)
    end

    #   test "returns 401 when admin password is invalid", %{conn: conn} do
    #     conn =
    #       post(conn, "/api/v1/admin/sign_in", %{
    #         "email" => "john@gmail.com",
    #         "password" => "12345678"
    #       })

    #     assert %{"status" => "unauthenticated"} = json_response(conn, 401)
    #   end
    # end
  end
end
