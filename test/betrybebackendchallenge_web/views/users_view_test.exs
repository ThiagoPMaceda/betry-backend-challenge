defmodule BetrybebackendchallengeWeb.UsersViewTest do
  use BetrybebackendchallengeWeb.ConnCase

  alias BetrybebackendchallengeWeb.UsersView

  describe "create/2" do
    test "create/2 returns a token" do
      token =
        "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJiZXRyeWJlYmFja2VuZGNoYWxsZW5nZSIsImV4cCI6MTYyMzYzODI2OSwiaWF0IjoxNjIxMjE5MDY5LCJpc3MiOiJiZXRyeWJlYmFja2VuZGNoYWxsZW5nZ"

      assert %{
               token:
                 "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJiZXRyeWJlYmFja2VuZGNoYWxsZW5nZSIsImV4cCI6MTYyMzYzODI2OSwiaWF0IjoxNjIxMjE5MDY5LCJpc3MiOiJiZXRyeWJlYmFja2VuZGNoYWxsZW5nZ"
             } == UsersView.render("create.json", %{token: token})
    end
  end

  describe "index/2" do
    test "index/2 returns a list of users" do
      response = [
        [
          %{
            id: 1,
            displayname: "Joe Doe",
            email: "joedoe@gmail.com",
            image:
              "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/joe.png"
          },
          %{
            id: 2,
            displayname: "Jane Doe",
            email: "jane@gmail.com",
            image:
              "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/jane.png"
          }
        ]
      ]

      users = [
        %{
          id: 1,
          displayname: "Joe Doe",
          email: "joedoe@gmail.com",
          image:
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/joe.png"
        },
        %{
          id: 2,
          displayname: "Jane Doe",
          email: "jane@gmail.com",
          image:
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/jane.png"
        }
      ]

      assert response == UsersView.render("index.json", %{users: users})
    end
  end

  describe "show/2" do
    test "show/2 returns a user" do
      user = [
        %{
          id: 1,
          displayname: "Joe Doe",
          email: "joedoe@gmail.com",
          image:
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/joe.png"
        }
      ]

      assert user == UsersView.render("show.json", %{user: user})
    end
  end
end
