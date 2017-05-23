defmodule Ewms.EquipmentTest do
  use Ewms.ModelCase

  alias Ewms.Equipment

  @valid_attrs %{enabled: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Equipment.changeset(%Equipment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Equipment.changeset(%Equipment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
