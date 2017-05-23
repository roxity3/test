defmodule Ewms.ConditionTest do
  use Ewms.ModelCase

  alias Ewms.Condition

  @valid_attrs %{enabled: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Condition.changeset(%Condition{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Condition.changeset(%Condition{}, @invalid_attrs)
    refute changeset.valid?
  end
end
