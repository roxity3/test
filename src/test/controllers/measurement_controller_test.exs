defmodule Ewms.MeasurementControllerTest do
  use Ewms.ConnCase

  alias Ewms.Measurement
  @valid_attrs %{enabled: true, image: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, measurement_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing measurements"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, measurement_path(conn, :new)
    assert html_response(conn, 200) =~ "New measurement"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, measurement_path(conn, :create), measurement: @valid_attrs
    assert redirected_to(conn) == measurement_path(conn, :index)
    assert Repo.get_by(Measurement, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, measurement_path(conn, :create), measurement: @invalid_attrs
    assert html_response(conn, 200) =~ "New measurement"
  end

  test "shows chosen resource", %{conn: conn} do
    measurement = Repo.insert! %Measurement{}
    conn = get conn, measurement_path(conn, :show, measurement)
    assert html_response(conn, 200) =~ "Show measurement"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, measurement_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    measurement = Repo.insert! %Measurement{}
    conn = get conn, measurement_path(conn, :edit, measurement)
    assert html_response(conn, 200) =~ "Edit measurement"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    measurement = Repo.insert! %Measurement{}
    conn = put conn, measurement_path(conn, :update, measurement), measurement: @valid_attrs
    assert redirected_to(conn) == measurement_path(conn, :show, measurement)
    assert Repo.get_by(Measurement, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    measurement = Repo.insert! %Measurement{}
    conn = put conn, measurement_path(conn, :update, measurement), measurement: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit measurement"
  end

  test "deletes chosen resource", %{conn: conn} do
    measurement = Repo.insert! %Measurement{}
    conn = delete conn, measurement_path(conn, :delete, measurement)
    assert redirected_to(conn) == measurement_path(conn, :index)
    refute Repo.get(Measurement, measurement.id)
  end
end
