defmodule Ewms.GetTest do
  use Ewms.ModelCase

  alias Ewms.Get

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Get.changeset(%Get{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Get.changeset(%Get{}, @invalid_attrs)
    refute changeset.valid?
  end
end
