defmodule Ewms.ManufacturerController do
  use Ewms.Web, :controller

  alias Ewms.Manufacturer

  def index(conn, _params) do
    manufacturers = Repo.all(Manufacturer)
    render(conn, "index.html", manufacturers: manufacturers)
  end

  def new(conn, _params) do
    changeset = Manufacturer.changeset(%Manufacturer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"manufacturer" => manufacturer_params}) do
    changeset = Manufacturer.changeset(%Manufacturer{}, manufacturer_params)

    case Repo.insert(changeset) do
      {:ok, _manufacturer} ->
        conn
        |> put_flash(:info, "Se creó correctamente el fabricante.")
        |> redirect(to: manufacturer_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    manufacturer = Repo.get!(Manufacturer, id)
    render(conn, "show.html", manufacturer: manufacturer)
  end

  def edit(conn, %{"id" => id}) do
    manufacturer = Repo.get!(Manufacturer, id)
    changeset = Manufacturer.changeset(manufacturer)
    render(conn, "edit.html", manufacturer: manufacturer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "manufacturer" => manufacturer_params}) do
    manufacturer = Repo.get!(Manufacturer, id)
    changeset = Manufacturer.changeset(manufacturer, manufacturer_params)

    case Repo.update(changeset) do
      {:ok, manufacturer} ->
        conn
        |> put_flash(:info, "Se actualizaron los datos del fabricante.")
        |> redirect(to: manufacturer_path(conn, :show, manufacturer))
      {:error, changeset} ->
        render(conn, "edit.html", manufacturer: manufacturer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    manufacturer = Repo.get!(Manufacturer, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(manufacturer)

    conn
    |> put_flash(:info, "Se eliminó el fabricante.")
    |> redirect(to: manufacturer_path(conn, :index))
  end
end
