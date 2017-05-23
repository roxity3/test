defmodule Ewms.PartControllerTest do
  use Ewms.ConnCase

  alias Ewms.Part
  @valid_attrs %{codmid: "some content", codmine: "some content", codpn: "some content", enabled: true, name: "some content", price: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, part_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing parts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, part_path(conn, :new)
    assert html_response(conn, 200) =~ "New part"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, part_path(conn, :create), part: @valid_attrs
    assert redirected_to(conn) == part_path(conn, :index)
    assert Repo.get_by(Part, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, part_path(conn, :create), part: @invalid_attrs
    assert html_response(conn, 200) =~ "New part"
  end

  test "shows chosen resource", %{conn: conn} do
    part = Repo.insert! %Part{}
    conn = get conn, part_path(conn, :show, part)
    assert html_response(conn, 200) =~ "Show part"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, part_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    part = Repo.insert! %Part{}
    conn = get conn, part_path(conn, :edit, part)
    assert html_response(conn, 200) =~ "Edit part"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    part = Repo.insert! %Part{}
    conn = put conn, part_path(conn, :update, part), part: @valid_attrs
    assert redirected_to(conn) == part_path(conn, :show, part)
    assert Repo.get_by(Part, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    part = Repo.insert! %Part{}
    conn = put conn, part_path(conn, :update, part), part: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit part"
  end

  test "deletes chosen resource", %{conn: conn} do
    part = Repo.insert! %Part{}
    conn = delete conn, part_path(conn, :delete, part)
    assert redirected_to(conn) == part_path(conn, :index)
    refute Repo.get(Part, part.id)
  end
end
