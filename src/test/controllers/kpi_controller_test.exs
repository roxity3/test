defmodule Ewms.KpiControllerTest do
  use Ewms.ConnCase

  alias Ewms.Kpi
  @valid_attrs %{enabled: true, is_percentage: true, limit: "120.5", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, kpi_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing kpis"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, kpi_path(conn, :new)
    assert html_response(conn, 200) =~ "New kpi"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, kpi_path(conn, :create), kpi: @valid_attrs
    assert redirected_to(conn) == kpi_path(conn, :index)
    assert Repo.get_by(Kpi, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, kpi_path(conn, :create), kpi: @invalid_attrs
    assert html_response(conn, 200) =~ "New kpi"
  end

  test "shows chosen resource", %{conn: conn} do
    kpi = Repo.insert! %Kpi{}
    conn = get conn, kpi_path(conn, :show, kpi)
    assert html_response(conn, 200) =~ "Show kpi"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, kpi_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    kpi = Repo.insert! %Kpi{}
    conn = get conn, kpi_path(conn, :edit, kpi)
    assert html_response(conn, 200) =~ "Edit kpi"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    kpi = Repo.insert! %Kpi{}
    conn = put conn, kpi_path(conn, :update, kpi), kpi: @valid_attrs
    assert redirected_to(conn) == kpi_path(conn, :show, kpi)
    assert Repo.get_by(Kpi, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    kpi = Repo.insert! %Kpi{}
    conn = put conn, kpi_path(conn, :update, kpi), kpi: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit kpi"
  end

  test "deletes chosen resource", %{conn: conn} do
    kpi = Repo.insert! %Kpi{}
    conn = delete conn, kpi_path(conn, :delete, kpi)
    assert redirected_to(conn) == kpi_path(conn, :index)
    refute Repo.get(Kpi, kpi.id)
  end
end
