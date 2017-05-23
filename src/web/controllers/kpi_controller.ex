defmodule Ewms.KpiController do
  use Ewms.Web, :controller

  alias Ewms.Kpi

  def index(conn, _params) do
    kpis = Repo.all(Kpi)
    render(conn, "index.html", kpis: kpis)
  end

  def new(conn, _params) do
    changeset = Kpi.changeset(%Kpi{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"kpi" => kpi_params}) do
    changeset = Kpi.changeset(%Kpi{}, kpi_params)

    case Repo.insert(changeset) do
      {:ok, _kpi} ->
        conn
        |> put_flash(:info, "Kpi created successfully.")
        |> redirect(to: kpi_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    kpi = Repo.get!(Kpi, id)
    render(conn, "show.html", kpi: kpi)
  end

  def edit(conn, %{"id" => id}) do
    kpi = Repo.get!(Kpi, id)
    changeset = Kpi.changeset(kpi)
    render(conn, "edit.html", kpi: kpi, changeset: changeset)
  end

  def update(conn, %{"id" => id, "kpi" => kpi_params}) do
    kpi = Repo.get!(Kpi, id)
    changeset = Kpi.changeset(kpi, kpi_params)

    case Repo.update(changeset) do
      {:ok, kpi} ->
        conn
        |> put_flash(:info, "Kpi updated successfully.")
        |> redirect(to: kpi_path(conn, :show, kpi))
      {:error, changeset} ->
        render(conn, "edit.html", kpi: kpi, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    kpi = Repo.get!(Kpi, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(kpi)

    conn
    |> put_flash(:info, "Kpi deleted successfully.")
    |> redirect(to: kpi_path(conn, :index))
  end
end
