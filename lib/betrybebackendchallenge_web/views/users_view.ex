defmodule BetrybebackendchallengeWeb.UsersView do
  use BetrybebackendchallengeWeb, :view

  def render("create.json", %{token: token}) do
    %{
      token: token
    }
  end

  def render("index.json", %{users: users}) do
    [users]
  end

  def render("show.json", %{user: user}) do
    user
  end
end
