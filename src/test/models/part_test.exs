defmodule Ewms.PartTest do
  use Ewms.ModelCase

  alias Ewms.Part

  @valid_attrs %{codmid: "some content", codmine: "some content", codpn: "some content", enabled: true, name: "some content", price: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Part.changeset(%Part{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Part.changeset(%Part{}, @invalid_attrs)
    refute changeset.valid?
  end
end
