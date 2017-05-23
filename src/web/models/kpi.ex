defmodule Ewms.Kpi do
  use Ewms.Web, :model

  schema "kpis" do
    field :name, :string
    field :limit, :decimal
    field :is_percentage, :boolean, default: false
    field :enabled, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :limit, :is_percentage, :enabled])
    |> validate_required([:name, :limit, :is_percentage, :enabled])
    |> unique_constraint(:name)
  end

  def alphabetical(query) do
    from k in query, order_by: k.name
  end

  def names_and_ids(query) do
    from k in query, select: {k.name, k.id}
  end
end
