defmodule Ewms.EquipmentBucketControllerTest do
  use Ewms.ConnCase

  alias Ewms.EquipmentBucket
  @valid_attrs %{finished_at: %{day: 17, month: 4, year: 2010}, started_at: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, equipment_bucket_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing equipments buckets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, equipment_bucket_path(conn, :new)
    assert html_response(conn, 200) =~ "New equipment bucket"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, equipment_bucket_path(conn, :create), equipment_bucket: @valid_attrs
    assert redirected_to(conn) == equipment_bucket_path(conn, :index)
    assert Repo.get_by(EquipmentBucket, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, equipment_bucket_path(conn, :create), equipment_bucket: @invalid_attrs
    assert html_response(conn, 200) =~ "New equipment bucket"
  end

  test "shows chosen resource", %{conn: conn} do
    equipment_bucket = Repo.insert! %EquipmentBucket{}
    conn = get conn, equipment_bucket_path(conn, :show, equipment_bucket)
    assert html_response(conn, 200) =~ "Show equipment bucket"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, equipment_bucket_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    equipment_bucket = Repo.insert! %EquipmentBucket{}
    conn = get conn, equipment_bucket_path(conn, :edit, equipment_bucket)
    assert html_response(conn, 200) =~ "Edit equipment bucket"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    equipment_bucket = Repo.insert! %EquipmentBucket{}
    conn = put conn, equipment_bucket_path(conn, :update, equipment_bucket), equipment_bucket: @valid_attrs
    assert redirected_to(conn) == equipment_bucket_path(conn, :show, equipment_bucket)
    assert Repo.get_by(EquipmentBucket, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    equipment_bucket = Repo.insert! %EquipmentBucket{}
    conn = put conn, equipment_bucket_path(conn, :update, equipment_bucket), equipment_bucket: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit equipment bucket"
  end

  test "deletes chosen resource", %{conn: conn} do
    equipment_bucket = Repo.insert! %EquipmentBucket{}
    conn = delete conn, equipment_bucket_path(conn, :delete, equipment_bucket)
    assert redirected_to(conn) == equipment_bucket_path(conn, :index)
    refute Repo.get(EquipmentBucket, equipment_bucket.id)
  end
end
