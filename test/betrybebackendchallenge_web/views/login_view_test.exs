defmodule BetrybebackendchallengeWeb.LoginViewTest do
  use BetrybebackendchallengeWeb.ConnCase

  alias BetrybebackendchallengeWeb.LoginView

  describe "render/2" do
    test "render/2 returns a token" do
      token =
        "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJiZXRyeWJlYmFja2VuZGNoYWxsZW5nZSIsImV4cCI6MTYyMzYzODI2OSwiaWF0IjoxNjIxMjE5MDY5LCJpc3MiOiJiZXRyeWJlYmFja2VuZGNoYWxsZW5nZ"

      assert %{
               token:
                 "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJiZXRyeWJlYmFja2VuZGNoYWxsZW5nZSIsImV4cCI6MTYyMzYzODI2OSwiaWF0IjoxNjIxMjE5MDY5LCJpc3MiOiJiZXRyeWJlYmFja2VuZGNoYWxsZW5nZ"
             } == LoginView.render("login.json", %{token: token})
    end
  end
end
