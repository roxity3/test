defmodule Ewms.ManufacturerTest do
  use Ewms.ModelCase

  alias Ewms.Manufacturer

  @valid_attrs %{enabled: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Manufacturer.changeset(%Manufacturer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Manufacturer.changeset(%Manufacturer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
