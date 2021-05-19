defmodule BetrybebackendchallengeWeb.PostsViewTest do
  use BetrybebackendchallengeWeb.ConnCase

  alias BetrybebackendchallengeWeb.PostsView

  describe "create/2" do
    test "create/2 returns the created post with the user ID" do
      post = %{
        title: "any title",
        content: "any content",
        user_id: 2,
        updated: "2021-05-16T18:33:56Z",
        published: "2021-05-16T18:33:56Z",
        id: 1,
        user: %{
          id: 2,
          displayname: "Joe Doe",
          email: "joedoe@gmail.com",
          image:
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/joe.png"
        }
      }

      response = %{
        title: "any title",
        content: "any content",
        userId: 2
      }

      assert response == PostsView.render("create.json", %{post: post})
    end
  end

  describe "index/2" do
    test "index/2 returns a list of posts from user" do
      response = [
        %{
          title: "first title",
          content: "first content",
          updated: "2021-05-16T18:33:56Z",
          published: "2021-05-16T18:33:56Z",
          id: 1,
          user: %{
            id: 1,
            displayName: "Joe Doe",
            email: "joedoe@gmail.com",
            image:
              "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/joe.png"
          }
        },
        %{
          title: "second title",
          content: "second content",
          updated: "2021-05-16T18:34:44Z",
          published: "2021-05-16T18:34:44Z",
          id: 2,
          user: %{
            id: 1,
            displayName: "Joe Doe",
            email: "joedoe@gmail.com",
            image:
              "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/joe.png"
          }
        }
      ]

      posts = [
        %{
          title: "first title",
          content: "first content",
          user_id: 1,
          updated: "2021-05-16T18:33:56Z",
          published: "2021-05-16T18:33:56Z",
          id: 1,
          user: %{
            id: 1,
            displayname: "Joe Doe",
            email: "joedoe@gmail.com",
            image:
              "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/joe.png"
          }
        },
        %{
          title: "second title",
          content: "second content",
          user_id: 1,
          updated: "2021-05-16T18:34:44Z",
          published: "2021-05-16T18:34:44Z",
          id: 2,
          user: %{
            id: 1,
            displayname: "Joe Doe",
            email: "joedoe@gmail.com",
            image:
              "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/joe.png"
          }
        }
      ]

      assert response == PostsView.render("index.json", %{posts: posts})
    end
  end

  describe "show/2" do
    test "show/2 returns a post" do
      response = %{
        title: "first title",
        content: "first content",
        updated: "2021-05-16T18:33:56Z",
        published: "2021-05-16T18:33:56Z",
        id: 1,
        user: %{
          id: 1,
          displayName: "Joe doe",
          email: "joedoe@gmail.com",
          image:
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/joe.png"
        }
      }

      post = %{
        title: "first title",
        content: "first content",
        user_id: 1,
        updated: "2021-05-16T18:33:56Z",
        published: "2021-05-16T18:33:56Z",
        id: 1,
        user: %{
          id: 1,
          displayname: "Joe doe",
          email: "joedoe@gmail.com",
          image:
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/joe.png"
        }
      }

      assert response == PostsView.render("show.json", %{post: post})
    end
  end

  describe "update/2" do
    test "update/2 returns the updated post" do
      response = %{
        title: "updated title",
        content: "updated content",
        userId: 1
      }

      updated_post = %{
        title: "updated title",
        content: "updated content",
        user_id: 1,
        updated: "2021-05-16T18:33:56Z",
        published: "2021-05-16T18:33:56Z",
        id: 1,
        user: %{
          id: 1,
          displayname: "Joe doe",
          email: "joedoe@gmail.com",
          image:
            "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/joe.png"
        }
      }

      assert response == PostsView.render("update.json", %{updated_post: updated_post})
    end
  end
end
