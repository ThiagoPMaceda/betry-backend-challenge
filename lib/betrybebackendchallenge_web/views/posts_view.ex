defmodule BetrybebackendchallengeWeb.PostsView do
  use BetrybebackendchallengeWeb, :view

  def render("create.json", %{post: post}) do
    %{
      title: post.title,
      content: post.content,
      userId: post.user_id
    }
  end
end
