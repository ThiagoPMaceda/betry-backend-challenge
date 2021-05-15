defmodule BetrybebackendchallengeWeb.FallbackController do
  use BetrybebackendchallengeWeb, :controller

  alias BetrybebackendchallengeWeb.ErrorView

  def call(conn, {:error, %{result: result, status: status}}) do
    IO.inspect(result)

    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end

  def call(conn, {:error, :email_or_password_invalid}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", result: "Campos inválidos")
  end
end
