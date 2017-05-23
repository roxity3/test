defmodule Ewms.Condition do
  use Ewms.Web, :model

  schema "conditions" do
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
    from c in query, order_by: c.name
  end

  def names_and_ids(query) do
    from c in query, select: {c.name, c.id}
  end
end
