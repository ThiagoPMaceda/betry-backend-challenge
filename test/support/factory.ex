defmodule Blog.Factory do
  @moduledoc """
  Module to create factorys to help in tests
  """
  use ExMachina.Ecto, repo: Betrybebackendchallenge.User

  def user_factory do
    %Betrybebackendchallenge.User{
      id: 1,
      displayname: "Brett Wiltshir",
      email: "hehe@gmail.com",
      image:
        "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
    }
  end

  def post_factory do
    %Betrybebackendchallenge.Post{
      content: "The whole text for the blog post goes here in this key",
      id: 2,
      published: "2021-05-16T18:34:44Z",
      title: "any title",
      updated: "2021-05-16T18:34:44Z",
      user: %{
        displayName: "Joe Doe",
        email: "joedoe@gmail.com",
        id: 1,
        image:
          "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
      }
    }
  end
end
