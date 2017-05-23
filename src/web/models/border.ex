defmodule Ewms.Border do
  use Ewms.Web, :model

  schema "borders" do
    field :name, :string
    field :label, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :label])
    |> validate_required([:name, :label])
  end

  def alphabetical(query) do
    from b in query, order_by: b.name
  end

  def names_and_ids(query) do
    from b in query, select: {b.name, b.id}
  end

end
