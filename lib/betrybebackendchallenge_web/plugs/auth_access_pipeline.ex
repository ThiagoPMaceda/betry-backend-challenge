defmodule BetrybebackendchallengeWeb.AuthAccessPipeline do
  @moduledoc """
  Auth access Pipeline to protected routes
  """
  use Guardian.Plug.Pipeline,
    module: BetrybebackendchallengeWeb.Guardian,
    error_handler: BetrybebackendchallengeWeb.AuthErrorHandler,
    otp_app: :betrybebackendchallenge

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
