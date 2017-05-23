defmodule Ewms.MagnitudeController do
  use Ewms.Web, :controller

  alias Ewms.Measurement
  alias Ewms.Part
  alias Ewms.Magnitude

  # def action(conn, _) do
  #   part = Repo.get!(Part, conn.params["part_id"])
  #   measurement = Repo.get!(part_measurements(part), conn.params["measurement_id"])
  #   args = [conn, conn.params, part, measurement]
  #   apply(__MODULE__, action_name(conn), args)
  # end

  def part_measurements(part) do
    assoc(part, :measurements)
  end

  def measurement_magnitudes(measurement) do
    assoc(measurement, :magnitudes)
  end

  def index(conn, _params) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurement = Repo.get!(part_measurements(part), conn.params["measurement_id"])
    magnitudes = Repo.all(measurement_magnitudes(measurement))
    render(conn, "index.html", part: part, measurement: measurement, magnitudes: magnitudes)
  end

  def new(conn, _params) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurement = Repo.get!(part_measurements(part), conn.params["measurement_id"])
    changeset =
      measurement
      |> build_assoc(:magnitudes)
      |> Magnitude.changeset()
    render(conn, "new.html", part: part, measurement: measurement, changeset: changeset)
  end

  def create(conn, %{"magnitude" => magnitude_params}) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurement = Repo.get!(part_measurements(part), conn.params["measurement_id"])
    changeset =
      measurement
      |> build_assoc(:magnitudes)
      |> Magnitude.changeset(magnitude_params)

    case Repo.insert(changeset) do
      {:ok, _magnitude} ->
        conn
        |> put_flash(:info, "Magnitude created successfully.")
        |> redirect(to: part_measurement_magnitude_path(conn, :index, part, measurement))
      {:error, changeset} ->
        render(conn, "new.html", part: part, measurement: measurement, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurement = Repo.get!(part_measurements(part), conn.params["measurement_id"])
    magnitude = Repo.get!(measurement_magnitudes(measurement), id)
    render(conn, "show.html", part: part, measurement: measurement, magnitude: magnitude)
  end

  def edit(conn, %{"id" => id}) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurement = Repo.get!(part_measurements(part), conn.params["measurement_id"])
    magnitude = Repo.get!(measurement_magnitudes(measurement), id)
    changeset = Magnitude.changeset(magnitude)
    render(conn, "edit.html", part: part, measurement: measurement, magnitude: magnitude, changeset: changeset)
  end

  def update(conn, %{"id" => id, "magnitude" => magnitude_params}) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurement = Repo.get!(part_measurements(part), conn.params["measurement_id"])
    magnitude = Repo.get!(measurement_magnitudes(measurement), id)
    changeset = Magnitude.changeset(magnitude, magnitude_params)

    case Repo.update(changeset) do
      {:ok, magnitude} ->
        conn
        |> put_flash(:info, "Magnitude updated successfully.")
        |> redirect(to: part_measurement_magnitude_path(conn, :show, part, measurement, magnitude))
      {:error, changeset} ->
        render(conn, "edit.html", part: part, measurement: measurement, magnitude: magnitude, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    part = Repo.get!(Part, conn.params["part_id"])
    measurement = Repo.get!(part_measurements(part), conn.params["measurement_id"])
    magnitude = Repo.get!(measurement_magnitudes(measurement), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(magnitude)

    conn
    |> put_flash(:info, "Magnitude deleted successfully.")
    |> redirect(to: part_measurement_magnitude_path(conn, :index, part, measurement))
  end
end
