defmodule Ewms.ConditionControllerTest do
  use Ewms.ConnCase

  alias Ewms.Condition
  @valid_attrs %{enabled: true, name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, condition_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing conditions"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, condition_path(conn, :new)
    assert html_response(conn, 200) =~ "New condition"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, condition_path(conn, :create), condition: @valid_attrs
    assert redirected_to(conn) == condition_path(conn, :index)
    assert Repo.get_by(Condition, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, condition_path(conn, :create), condition: @invalid_attrs
    assert html_response(conn, 200) =~ "New condition"
  end

  test "shows chosen resource", %{conn: conn} do
    condition = Repo.insert! %Condition{}
    conn = get conn, condition_path(conn, :show, condition)
    assert html_response(conn, 200) =~ "Show condition"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, condition_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    condition = Repo.insert! %Condition{}
    conn = get conn, condition_path(conn, :edit, condition)
    assert html_response(conn, 200) =~ "Edit condition"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    condition = Repo.insert! %Condition{}
    conn = put conn, condition_path(conn, :update, condition), condition: @valid_attrs
    assert redirected_to(conn) == condition_path(conn, :show, condition)
    assert Repo.get_by(Condition, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    condition = Repo.insert! %Condition{}
    conn = put conn, condition_path(conn, :update, condition), condition: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit condition"
  end

  test "deletes chosen resource", %{conn: conn} do
    condition = Repo.insert! %Condition{}
    conn = delete conn, condition_path(conn, :delete, condition)
    assert redirected_to(conn) == condition_path(conn, :index)
    refute Repo.get(Condition, condition.id)
  end
end
