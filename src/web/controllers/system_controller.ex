defmodule Ewms.SystemController do
  use Ewms.Web, :controller

  alias Ewms.System

  def index(conn, _params) do
    systems = Repo.all(System)
    render(conn, "index.html", systems: systems)
  end

  def new(conn, _params) do
    changeset = System.changeset(%System{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"system" => system_params}) do
    changeset = System.changeset(%System{}, system_params)

    case Repo.insert(changeset) do
      {:ok, _system} ->
        conn
        |> put_flash(:info, "Se creó correctamente el sistema.")
        |> redirect(to: system_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    system = Repo.get!(System, id)
    render(conn, "show.html", system: system)
  end

  def edit(conn, %{"id" => id}) do
    system = Repo.get!(System, id)
    changeset = System.changeset(system)
    render(conn, "edit.html", system: system, changeset: changeset)
  end

  def update(conn, %{"id" => id, "system" => system_params}) do
    system = Repo.get!(System, id)
    changeset = System.changeset(system, system_params)

    case Repo.update(changeset) do
      {:ok, system} ->
        conn
        |> put_flash(:info, "Se actualizaron los datos del sistema.")
        |> redirect(to: system_path(conn, :show, system))
      {:error, changeset} ->
        render(conn, "edit.html", system: system, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    system = Repo.get!(System, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(system)

    conn
    |> put_flash(:info, "Se eliminó el sistema.")
    |> redirect(to: system_path(conn, :index))
  end
end
