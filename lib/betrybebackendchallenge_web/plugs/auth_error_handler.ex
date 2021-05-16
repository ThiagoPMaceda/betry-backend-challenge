defmodule BetrybebackendchallengeWeb.AuthErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason = :invalid_token}, _opts) do
    body = Jason.encode!(%{message: "Token expirado ou inválido"})
    IO.inspect(reason)
    IO.inspect(type)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason = :unauthenticated}, _opts) do
    body = Jason.encode!(%{message: "Token não encontrado"})
    IO.inspect(reason)
    IO.inspect(type)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason}, _opts) do
    body = Jason.encode!(%{message: to_string(type)})
    IO.inspect(reason)
    IO.inspect(type)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end
end
