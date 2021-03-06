defmodule BetrybebackendchallengeWeb.Router do
  use BetrybebackendchallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :user_logged do
    plug :accepts, ["json"]
    plug BetrybebackendchallengeWeb.AuthAccessPipeline
  end

  scope "/api", BetrybebackendchallengeWeb do
    pipe_through :api

    resources "/user", UsersController, only: [:create]

    resources "/login", LoginController, only: [:create]
  end

  scope "/api", BetrybebackendchallengeWeb do
    pipe_through :user_logged

    resources "/user", UsersController, only: [:show, :index]

    delete "/user/me", MeController, :delete

    resources "/post", PostsController, only: [:create, :index, :show, :update, :delete]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: BetrybebackendchallengeWeb.Telemetry
    end
  end
end
