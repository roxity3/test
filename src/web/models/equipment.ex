defmodule Ewms.Equipment do
  use Ewms.Web, :model

  schema "equipments" do
    field :name, :string
    field :enabled, :boolean, default: false
    belongs_to :project, Ewms.Project
    belongs_to :model, Ewms.Model
    has_many :equipments_buckets, Ewms.EquipmentBucket

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :enabled], [:project_id, :model_id])
    |> validate_required([:name, :enabled])
    |> unique_constraint(:name)
  end
end
