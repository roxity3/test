defmodule Ewms.SystemControllerTest do
  use Ewms.ConnCase

  alias Ewms.System
  @valid_attrs %{enabled: true, name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, system_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing systems"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, system_path(conn, :new)
    assert html_response(conn, 200) =~ "New system"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, system_path(conn, :create), system: @valid_attrs
    assert redirected_to(conn) == system_path(conn, :index)
    assert Repo.get_by(System, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, system_path(conn, :create), system: @invalid_attrs
    assert html_response(conn, 200) =~ "New system"
  end

  test "shows chosen resource", %{conn: conn} do
    system = Repo.insert! %System{}
    conn = get conn, system_path(conn, :show, system)
    assert html_response(conn, 200) =~ "Show system"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, system_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    system = Repo.insert! %System{}
    conn = get conn, system_path(conn, :edit, system)
    assert html_response(conn, 200) =~ "Edit system"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    system = Repo.insert! %System{}
    conn = put conn, system_path(conn, :update, system), system: @valid_attrs
    assert redirected_to(conn) == system_path(conn, :show, system)
    assert Repo.get_by(System, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    system = Repo.insert! %System{}
    conn = put conn, system_path(conn, :update, system), system: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit system"
  end

  test "deletes chosen resource", %{conn: conn} do
    system = Repo.insert! %System{}
    conn = delete conn, system_path(conn, :delete, system)
    assert redirected_to(conn) == system_path(conn, :index)
    refute Repo.get(System, system.id)
  end
end
