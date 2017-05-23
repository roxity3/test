defmodule Ewms.GetControllerTest do
  use Ewms.ConnCase

  alias Ewms.Get
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, get_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing gets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, get_path(conn, :new)
    assert html_response(conn, 200) =~ "New get"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, get_path(conn, :create), get: @valid_attrs
    assert redirected_to(conn) == get_path(conn, :index)
    assert Repo.get_by(Get, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, get_path(conn, :create), get: @invalid_attrs
    assert html_response(conn, 200) =~ "New get"
  end

  test "shows chosen resource", %{conn: conn} do
    get = Repo.insert! %Get{}
    conn = get conn, get_path(conn, :show, get)
    assert html_response(conn, 200) =~ "Show get"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, get_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    get = Repo.insert! %Get{}
    conn = get conn, get_path(conn, :edit, get)
    assert html_response(conn, 200) =~ "Edit get"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    get = Repo.insert! %Get{}
    conn = put conn, get_path(conn, :update, get), get: @valid_attrs
    assert redirected_to(conn) == get_path(conn, :show, get)
    assert Repo.get_by(Get, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    get = Repo.insert! %Get{}
    conn = put conn, get_path(conn, :update, get), get: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit get"
  end

  test "deletes chosen resource", %{conn: conn} do
    get = Repo.insert! %Get{}
    conn = delete conn, get_path(conn, :delete, get)
    assert redirected_to(conn) == get_path(conn, :index)
    refute Repo.get(Get, get.id)
  end
end
