defmodule Ewms.ManufacturerControllerTest do
  use Ewms.ConnCase

  alias Ewms.Manufacturer
  @valid_attrs %{enabled: true, name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, manufacturer_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing manufacturers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, manufacturer_path(conn, :new)
    assert html_response(conn, 200) =~ "New manufacturer"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, manufacturer_path(conn, :create), manufacturer: @valid_attrs
    assert redirected_to(conn) == manufacturer_path(conn, :index)
    assert Repo.get_by(Manufacturer, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, manufacturer_path(conn, :create), manufacturer: @invalid_attrs
    assert html_response(conn, 200) =~ "New manufacturer"
  end

  test "shows chosen resource", %{conn: conn} do
    manufacturer = Repo.insert! %Manufacturer{}
    conn = get conn, manufacturer_path(conn, :show, manufacturer)
    assert html_response(conn, 200) =~ "Show manufacturer"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, manufacturer_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    manufacturer = Repo.insert! %Manufacturer{}
    conn = get conn, manufacturer_path(conn, :edit, manufacturer)
    assert html_response(conn, 200) =~ "Edit manufacturer"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    manufacturer = Repo.insert! %Manufacturer{}
    conn = put conn, manufacturer_path(conn, :update, manufacturer), manufacturer: @valid_attrs
    assert redirected_to(conn) == manufacturer_path(conn, :show, manufacturer)
    assert Repo.get_by(Manufacturer, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    manufacturer = Repo.insert! %Manufacturer{}
    conn = put conn, manufacturer_path(conn, :update, manufacturer), manufacturer: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit manufacturer"
  end

  test "deletes chosen resource", %{conn: conn} do
    manufacturer = Repo.insert! %Manufacturer{}
    conn = delete conn, manufacturer_path(conn, :delete, manufacturer)
    assert redirected_to(conn) == manufacturer_path(conn, :index)
    refute Repo.get(Manufacturer, manufacturer.id)
  end
end
