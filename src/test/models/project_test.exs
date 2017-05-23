defmodule Ewms.ProjectTest do
  use Ewms.ModelCase

  alias Ewms.Project

  @valid_attrs %{finished_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, name: "some content", started_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Project.changeset(%Project{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Project.changeset(%Project{}, @invalid_attrs)
    refute changeset.valid?
  end
end
