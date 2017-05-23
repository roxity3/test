defmodule Ewms.MagnitudeControllerTest do
  use Ewms.ConnCase

  alias Ewms.Magnitude
  @valid_attrs %{enabled: true, initial: "120.5", maximum: "120.5", name: "some content", value: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, magnitude_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing magnitudes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, magnitude_path(conn, :new)
    assert html_response(conn, 200) =~ "New magnitude"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, magnitude_path(conn, :create), magnitude: @valid_attrs
    assert redirected_to(conn) == magnitude_path(conn, :index)
    assert Repo.get_by(Magnitude, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, magnitude_path(conn, :create), magnitude: @invalid_attrs
    assert html_response(conn, 200) =~ "New magnitude"
  end

  test "shows chosen resource", %{conn: conn} do
    magnitude = Repo.insert! %Magnitude{}
    conn = get conn, magnitude_path(conn, :show, magnitude)
    assert html_response(conn, 200) =~ "Show magnitude"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, magnitude_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    magnitude = Repo.insert! %Magnitude{}
    conn = get conn, magnitude_path(conn, :edit, magnitude)
    assert html_response(conn, 200) =~ "Edit magnitude"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    magnitude = Repo.insert! %Magnitude{}
    conn = put conn, magnitude_path(conn, :update, magnitude), magnitude: @valid_attrs
    assert redirected_to(conn) == magnitude_path(conn, :show, magnitude)
    assert Repo.get_by(Magnitude, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    magnitude = Repo.insert! %Magnitude{}
    conn = put conn, magnitude_path(conn, :update, magnitude), magnitude: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit magnitude"
  end

  test "deletes chosen resource", %{conn: conn} do
    magnitude = Repo.insert! %Magnitude{}
    conn = delete conn, magnitude_path(conn, :delete, magnitude)
    assert redirected_to(conn) == magnitude_path(conn, :index)
    refute Repo.get(Magnitude, magnitude.id)
  end
end
