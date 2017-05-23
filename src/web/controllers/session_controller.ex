defmodule Ewms.SessionController do
  use Ewms.Web, :controller

  def new(conn, _) do
    render conn, "new.html",
      layout: {Ewms.LayoutView, "base.html"}
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case Ewms.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo)
    do
      {:ok, conn} ->
        conn
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "invalid username/password combination")
        |> render("new.html",
            layout: {Ewms.LayoutView, "base.html"})
    end
  end

  def delete(conn, _) do
    conn
    |> Ewms.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
