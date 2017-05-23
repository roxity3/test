# defmodule Ewms.UserController do
#   use Ewms.Web, :controller
#
#   alias Ewms.User
#
#   def new(conn, _params) do
#     render conn, "new.html", changeset: User.register_changeset(%User{})
#   end
#
#   def create(conn, %{"user" => user_params}) do
#     result=
#      %User{}
#      |> User.register_changeset(user_params)
#      |> Repo.insert()
#
#    case result do
#      {:ok, _user} ->
#        conn
#        |> put_flash(:info, "Registration successful")
#        |> redirect(to: session_path(conn, :new))
#      {:error, changeset} ->
#        render conn, "new.html", changeset: changeset
#    end
#   end
# end

defmodule Ewms.UserController do
  use Ewms.Web, :controller

  alias Ewms.Repo
  alias Ewms.User
  alias Ewms.Authorization

  plug :authenticate when action in [:index, :show]

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "Debe haber iniciado sesión para acceder a esa página")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Ewms.Auth.login(user)
        |> put_flash(:info, "#{user.name} creado satisfactoriamente.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Se actualizaron los datos del usuario.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    conn
    |> put_flash(:info, "Se eliminó el usuario #{user.name}.")
    |> redirect(to: user_path(conn, :index))
  end
end
