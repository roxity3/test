defmodule Ewms.Price do
  use Ewms.Web, :model

  schema "prices" do
    field :started_at, Ecto.Date
    field :finished_at, Ecto.Date
    field :amount, :decimal
    belongs_to :project, Ewms.Project
    belongs_to :part, Ewms.Part

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:part_id, :amount],[:started_at, :finished_at])
    |> validate_required([:part_id, :amount])
  end
end
