defmodule Ewms.ComponentTest do
  use Ewms.ModelCase

  alias Ewms.Component

  @valid_attrs %{enabled: true, measurabled: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Component.changeset(%Component{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Component.changeset(%Component{}, @invalid_attrs)
    refute changeset.valid?
  end
end
