defmodule BetrybebackendchallengeWeb.UsersView do
  use BetrybebackendchallengeWeb, :view

  def render("create.json", %{token: token}) do
    %{
      token: token
    }
  end
end
