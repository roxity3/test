defmodule Ewms.Component do
  use Ewms.Web, :model

  schema "components" do
    field :name, :string
    field :position, :integer
    field :measurabled, :boolean, default: false
    field :enabled, :boolean, default: false
    belongs_to :border, Ewms.Border

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :position, :measurabled, :enabled, :border_id])
    |> validate_required([:name, :position, :measurabled, :enabled, :border_id])
    |> unique_constraint(:name)
  end

  def alphabetical(query) do
    from c in query, order_by: c.name
  end

  def names_and_ids(query) do
    from c in query, select: {c.name, c.id}
  end
end
