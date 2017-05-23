defmodule Ewms.BucketControllerTest do
  use Ewms.ConnCase

  alias Ewms.Bucket
  @valid_attrs %{enabled: true, name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bucket_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing buckets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bucket_path(conn, :new)
    assert html_response(conn, 200) =~ "New bucket"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bucket_path(conn, :create), bucket: @valid_attrs
    assert redirected_to(conn) == bucket_path(conn, :index)
    assert Repo.get_by(Bucket, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bucket_path(conn, :create), bucket: @invalid_attrs
    assert html_response(conn, 200) =~ "New bucket"
  end

  test "shows chosen resource", %{conn: conn} do
    bucket = Repo.insert! %Bucket{}
    conn = get conn, bucket_path(conn, :show, bucket)
    assert html_response(conn, 200) =~ "Show bucket"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bucket_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    bucket = Repo.insert! %Bucket{}
    conn = get conn, bucket_path(conn, :edit, bucket)
    assert html_response(conn, 200) =~ "Edit bucket"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    bucket = Repo.insert! %Bucket{}
    conn = put conn, bucket_path(conn, :update, bucket), bucket: @valid_attrs
    assert redirected_to(conn) == bucket_path(conn, :show, bucket)
    assert Repo.get_by(Bucket, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bucket = Repo.insert! %Bucket{}
    conn = put conn, bucket_path(conn, :update, bucket), bucket: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bucket"
  end

  test "deletes chosen resource", %{conn: conn} do
    bucket = Repo.insert! %Bucket{}
    conn = delete conn, bucket_path(conn, :delete, bucket)
    assert redirected_to(conn) == bucket_path(conn, :index)
    refute Repo.get(Bucket, bucket.id)
  end
end
