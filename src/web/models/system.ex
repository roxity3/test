defmodule Ewms.System do
  use Ewms.Web, :model

  schema "systems" do
    field :name, :string
    field :enabled, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :enabled])
    |> validate_required([:name, :enabled])
    |> unique_constraint(:name)
  end

  def alphabetical(query) do
    from s in query, order_by: s.name
  end

  def names_and_ids(query) do
    from s in query, select: {s.name, s.id}
  end
end
