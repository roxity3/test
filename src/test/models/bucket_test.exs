defmodule Ewms.BucketTest do
  use Ewms.ModelCase

  alias Ewms.Bucket

  @valid_attrs %{enabled: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bucket.changeset(%Bucket{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bucket.changeset(%Bucket{}, @invalid_attrs)
    refute changeset.valid?
  end
end
