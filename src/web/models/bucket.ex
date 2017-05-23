defmodule Ewms.Bucket do
  use Ewms.Web, :model
  use Arc.Ecto.Schema

  schema "buckets" do
    field :name, :string
    field :image, Ewms.ImageUploader.Type
    field :enabled, :boolean, default: false
    belongs_to :project, Ewms.Project
    belongs_to :system, Ewms.System
    belongs_to :state, Ewms.State
    has_many :gets, Ewms.Get
    has_many :equipments_buckets, Ewms.EquipmentBucket
    many_to_many :parts, Ewms.Part, join_through: "buckets_parts"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :image, :enabled, :project_id, :system_id, :state_id])
    |> cast_attachments(params, [:image])
    |> validate_required([:name, :image, :enabled, :project_id, :system_id, :state_id])
    |> unique_constraint(:name)
  end

  def alphabetical(query) do
    from b in query, order_by: b.name
  end

  def names_and_ids(query) do
    from b in query, select: {b.name, b.id}
  end
end
