defmodule Ewms.BucketPartTest do
  use Ewms.ModelCase

  alias Ewms.BucketPart

  @valid_attrs %{initial_value: "120.5", max_wear_value: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BucketPart.changeset(%BucketPart{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BucketPart.changeset(%BucketPart{}, @invalid_attrs)
    refute changeset.valid?
  end
end
