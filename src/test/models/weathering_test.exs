defmodule Ewms.WeatheringTest do
  use Ewms.ModelCase

  alias Ewms.Weathering

  @valid_attrs %{registered_at: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Weathering.changeset(%Weathering{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Weathering.changeset(%Weathering{}, @invalid_attrs)
    refute changeset.valid?
  end
end
