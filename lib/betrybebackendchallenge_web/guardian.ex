defmodule BetrybebackendchallengeWeb.Guardian do
  @moduledoc """
  Guardian Setup Module
  """
  use Guardian, otp_app: :betrybebackendchallenge

  alias Betrybebackendchallenge.GetUser

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = GetUser.run(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
