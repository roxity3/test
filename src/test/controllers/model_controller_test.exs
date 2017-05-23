defmodule Ewms.ModelControllerTest do
  use Ewms.ConnCase

  alias Ewms.Model
  @valid_attrs %{enabled: true, name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, model_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing models"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, model_path(conn, :new)
    assert html_response(conn, 200) =~ "New model"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, model_path(conn, :create), model: @valid_attrs
    assert redirected_to(conn) == model_path(conn, :index)
    assert Repo.get_by(Model, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, model_path(conn, :create), model: @invalid_attrs
    assert html_response(conn, 200) =~ "New model"
  end

  test "shows chosen resource", %{conn: conn} do
    model = Repo.insert! %Model{}
    conn = get conn, model_path(conn, :show, model)
    assert html_response(conn, 200) =~ "Show model"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, model_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    model = Repo.insert! %Model{}
    conn = get conn, model_path(conn, :edit, model)
    assert html_response(conn, 200) =~ "Edit model"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    model = Repo.insert! %Model{}
    conn = put conn, model_path(conn, :update, model), model: @valid_attrs
    assert redirected_to(conn) == model_path(conn, :show, model)
    assert Repo.get_by(Model, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    model = Repo.insert! %Model{}
    conn = put conn, model_path(conn, :update, model), model: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit model"
  end

  test "deletes chosen resource", %{conn: conn} do
    model = Repo.insert! %Model{}
    conn = delete conn, model_path(conn, :delete, model)
    assert redirected_to(conn) == model_path(conn, :index)
    refute Repo.get(Model, model.id)
  end
end
