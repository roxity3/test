defmodule Ewms.Manufacturer do
  use Ewms.Web, :model

  schema "manufacturers" do
    field :name, :string
    field :enabled, :boolean, default: true

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
    from m in query, order_by: m.name
  end

  def names_and_ids(query) do
    from m in query, select: {m.name, m.id}
  end
end
