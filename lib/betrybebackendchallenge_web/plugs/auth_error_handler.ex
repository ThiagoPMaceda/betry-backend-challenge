defmodule BetrybebackendchallengeWeb.AuthErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type = :invalid_token, _reason}, _opts) do
    body = Jason.encode!(%{message: "Token expirado ou inválido"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type = :unauthenticated, _reason}, _opts) do
    body = Jason.encode!(%{message: "Token não encontrado"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(type)})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end
end
