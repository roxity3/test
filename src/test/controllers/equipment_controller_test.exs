defmodule Ewms.EquipmentControllerTest do
  use Ewms.ConnCase

  alias Ewms.Equipment
  @valid_attrs %{enabled: true, name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, equipment_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing equipments"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, equipment_path(conn, :new)
    assert html_response(conn, 200) =~ "New equipment"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, equipment_path(conn, :create), equipment: @valid_attrs
    assert redirected_to(conn) == equipment_path(conn, :index)
    assert Repo.get_by(Equipment, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, equipment_path(conn, :create), equipment: @invalid_attrs
    assert html_response(conn, 200) =~ "New equipment"
  end

  test "shows chosen resource", %{conn: conn} do
    equipment = Repo.insert! %Equipment{}
    conn = get conn, equipment_path(conn, :show, equipment)
    assert html_response(conn, 200) =~ "Show equipment"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, equipment_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    equipment = Repo.insert! %Equipment{}
    conn = get conn, equipment_path(conn, :edit, equipment)
    assert html_response(conn, 200) =~ "Edit equipment"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    equipment = Repo.insert! %Equipment{}
    conn = put conn, equipment_path(conn, :update, equipment), equipment: @valid_attrs
    assert redirected_to(conn) == equipment_path(conn, :show, equipment)
    assert Repo.get_by(Equipment, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    equipment = Repo.insert! %Equipment{}
    conn = put conn, equipment_path(conn, :update, equipment), equipment: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit equipment"
  end

  test "deletes chosen resource", %{conn: conn} do
    equipment = Repo.insert! %Equipment{}
    conn = delete conn, equipment_path(conn, :delete, equipment)
    assert redirected_to(conn) == equipment_path(conn, :index)
    refute Repo.get(Equipment, equipment.id)
  end
end
