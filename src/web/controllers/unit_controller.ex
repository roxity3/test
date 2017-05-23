defmodule Ewms.UnitController do
  use Ewms.Web, :controller

  alias Ewms.Unit

  def index(conn, _params) do
    units = Repo.all(Unit)
    render(conn, "index.html", units: units)
  end

  def new(conn, _params) do
    changeset = Unit.changeset(%Unit{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"unit" => unit_params}) do
    changeset = Unit.changeset(%Unit{}, unit_params)

    case Repo.insert(changeset) do
      {:ok, _unit} ->
        conn
        |> put_flash(:info, "Se creó correctamente la unidad de medida.")
        |> redirect(to: unit_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    unit = Repo.get!(Unit, id)
    render(conn, "show.html", unit: unit)
  end

  def edit(conn, %{"id" => id}) do
    unit = Repo.get!(Unit, id)
    changeset = Unit.changeset(unit)
    render(conn, "edit.html", unit: unit, changeset: changeset)
  end

  def update(conn, %{"id" => id, "unit" => unit_params}) do
    unit = Repo.get!(Unit, id)
    changeset = Unit.changeset(unit, unit_params)

    case Repo.update(changeset) do
      {:ok, unit} ->
        conn
        |> put_flash(:info, "Se editaron los datos de la unidad de medida.")
        |> redirect(to: unit_path(conn, :show, unit))
      {:error, changeset} ->
        render(conn, "edit.html", unit: unit, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    unit = Repo.get!(Unit, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(unit)

    conn
    |> put_flash(:info, "Se eliminó la unidad de medida.")
    |> redirect(to: unit_path(conn, :index))
  end
end
