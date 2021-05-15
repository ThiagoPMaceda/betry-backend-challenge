defmodule BetrybebackendchallengeWeb.LoginView do
  use BetrybebackendchallengeWeb, :view

  def render("login.json", %{token: token}) do
    %{
      token: token
    }
  end
end
