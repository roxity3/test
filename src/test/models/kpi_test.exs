defmodule Ewms.KpiTest do
  use Ewms.ModelCase

  alias Ewms.Kpi

  @valid_attrs %{enabled: true, is_percentage: true, limit: "120.5", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Kpi.changeset(%Kpi{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Kpi.changeset(%Kpi{}, @invalid_attrs)
    refute changeset.valid?
  end
end
