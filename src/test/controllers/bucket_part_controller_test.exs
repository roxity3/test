defmodule Ewms.BucketPartControllerTest do
  use Ewms.ConnCase

  alias Ewms.BucketPart
  @valid_attrs %{initial_value: "120.5", max_wear_value: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bucket_part_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing buckets parts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bucket_part_path(conn, :new)
    assert html_response(conn, 200) =~ "New bucket part"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bucket_part_path(conn, :create), bucket_part: @valid_attrs
    assert redirected_to(conn) == bucket_part_path(conn, :index)
    assert Repo.get_by(BucketPart, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bucket_part_path(conn, :create), bucket_part: @invalid_attrs
    assert html_response(conn, 200) =~ "New bucket part"
  end

  test "shows chosen resource", %{conn: conn} do
    bucket_part = Repo.insert! %BucketPart{}
    conn = get conn, bucket_part_path(conn, :show, bucket_part)
    assert html_response(conn, 200) =~ "Show bucket part"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bucket_part_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    bucket_part = Repo.insert! %BucketPart{}
    conn = get conn, bucket_part_path(conn, :edit, bucket_part)
    assert html_response(conn, 200) =~ "Edit bucket part"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    bucket_part = Repo.insert! %BucketPart{}
    conn = put conn, bucket_part_path(conn, :update, bucket_part), bucket_part: @valid_attrs
    assert redirected_to(conn) == bucket_part_path(conn, :show, bucket_part)
    assert Repo.get_by(BucketPart, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bucket_part = Repo.insert! %BucketPart{}
    conn = put conn, bucket_part_path(conn, :update, bucket_part), bucket_part: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bucket part"
  end

  test "deletes chosen resource", %{conn: conn} do
    bucket_part = Repo.insert! %BucketPart{}
    conn = delete conn, bucket_part_path(conn, :delete, bucket_part)
    assert redirected_to(conn) == bucket_part_path(conn, :index)
    refute Repo.get(BucketPart, bucket_part.id)
  end
end
