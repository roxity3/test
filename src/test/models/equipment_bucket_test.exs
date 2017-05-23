defmodule Ewms.EquipmentBucketTest do
  use Ewms.ModelCase

  alias Ewms.EquipmentBucket

  @valid_attrs %{finished_at: %{day: 17, month: 4, year: 2010}, started_at: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = EquipmentBucket.changeset(%EquipmentBucket{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = EquipmentBucket.changeset(%EquipmentBucket{}, @invalid_attrs)
    refute changeset.valid?
  end
end
