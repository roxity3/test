defmodule Ewms.SystemTest do
  use Ewms.ModelCase

  alias Ewms.System

  @valid_attrs %{enabled: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = System.changeset(%System{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = System.changeset(%System{}, @invalid_attrs)
    refute changeset.valid?
  end
end
