defmodule Ewms.Unit do
  use Ewms.Web, :model

  schema "units" do
    field :name, :string
    field :symbol, :string
    field :enabled, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :symbol, :enabled])
    |> validate_required([:name, :symbol, :enabled])
    |> unique_constraint(:name)
  end

  def alphabetical(query) do
    from u in query, order_by: u.name
  end

  def names_and_ids(query) do
    from u in query, select: {u.name, u.id}
  end
end
