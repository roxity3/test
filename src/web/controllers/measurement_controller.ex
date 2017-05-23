defmodule Ewms.MeasurementController do
  use Ewms.Web, :controller

  alias Ewms.Part
  alias Ewms.Measurement

  # def action(conn, _) do
  #   part = Repo.get!(Part, conn.params["part_id"])
  #   args = [conn, conn.params, part]
  #   apply(__MODULE__, action_name(conn), args)
  # end

  def part_measurements(part) do
    assoc(part, :measurements)
  end

  def index(conn, _params) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurements = Repo.all(part_measurements(part))
    render(conn, "index.html", part: part, measurements: measurements)
  end

  def new(conn, _params) do
    part = Repo.get!(Part, conn.params["part_id"])
    changeset =
      part
      |> build_assoc(:measurements)
      |> Measurement.changeset()
    render(conn, "new.html", part: part, changeset: changeset)
  end

  def create(conn, %{"measurement" => measurement_params}) do
    part = Repo.get!(Part, conn.params["part_id"])
    changeset =
      part
      |> build_assoc(:measurements)
      |> Measurement.changeset(measurement_params)

    case Repo.insert(changeset) do
      {:ok, _measurement} ->
        conn
        |> put_flash(:info, "Se creó correctamente la medida.")
        |> redirect(to: part_measurement_path(conn, :index, part))
      {:error, changeset} ->
        render(conn, "new.html", part: part, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurement = Repo.get!(part_measurements(part), id)
    render(conn, "show.html", part: part, measurement: measurement)
  end

  def edit(conn, %{"id" => id}) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurement = Repo.get!(part_measurements(part), id)
    changeset = Measurement.changeset(measurement)
    render(conn, "edit.html", part: part, measurement: measurement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "measurement" => measurement_params}) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurement = Repo.get!(part_measurements(part), id)
    changeset = Measurement.changeset(measurement, measurement_params)

    case Repo.update(changeset) do
      {:ok, measurement} ->
        conn
        |> put_flash(:info, "Se actualizó la medida.")
        |> redirect(to: part_measurement_path(conn, :show, part, measurement))
      {:error, changeset} ->
        render(conn, "edit.html", part: part, measurement: measurement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurement = Repo.get!(part_measurements(part), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(measurement)

    conn
    |> put_flash(:info, "Se eliminó la medida.")
    |> redirect(to: part_measurement_path(conn, :index, part))
  end
end
