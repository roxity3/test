defmodule Ewms.MagnitudeTest do
  use Ewms.ModelCase

  alias Ewms.Magnitude

  @valid_attrs %{enabled: true, initial: "120.5", maximum: "120.5", name: "some content", value: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Magnitude.changeset(%Magnitude{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Magnitude.changeset(%Magnitude{}, @invalid_attrs)
    refute changeset.valid?
  end
end
