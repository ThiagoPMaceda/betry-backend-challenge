defmodule BetrybebackendchallengeWeb.PostsView do
  use BetrybebackendchallengeWeb, :view

  def render("create.json", %{post: post}) do
    %{
      title: post.title,
      content: post.content,
      userId: post.user_id
    }
  end

  def render("index.json", %{posts_and_users: posts_and_users}) do
    posts_and_users
  end

  def render("show.json", %{post: post}) do
    %{
      title: post.title,
      id: post.id,
      content: post.content,
      published: post.published,
      updated: post.updated,
      user: %{
        id: post.user.id,
        displayName: post.user.displayname,
        email: post.user.email,
        image: post.user.image
      }
    }
  end

  def render("update.json", %{updated_post: updated_post}) do
    %{
      title: updated_post.title,
      content: updated_post.content,
      userId: updated_post.user_id
    }
  end
end
