defmodule Ewms.PriceTest do
  use Ewms.ModelCase

  alias Ewms.Price

  @valid_attrs %{amount: "120.5", finished_at: %{day: 17, month: 4, year: 2010}, started_at: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Price.changeset(%Price{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Price.changeset(%Price{}, @invalid_attrs)
    refute changeset.valid?
  end
end
