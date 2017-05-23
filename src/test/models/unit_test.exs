defmodule Ewms.UnitTest do
  use Ewms.ModelCase

  alias Ewms.Unit

  @valid_attrs %{enabled: true, name: "some content", symbol: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Unit.changeset(%Unit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Unit.changeset(%Unit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
