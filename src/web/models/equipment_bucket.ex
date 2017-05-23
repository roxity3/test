defmodule Ewms.EquipmentBucket do
  use Ewms.Web, :model

  # @derive {Poison.Encoder, only: [
  #     :started_at,
  #     :finished_at,
  #     :equipment_id,
  #     :bucket_id
  #   ]}
  schema "equipments_buckets" do
    field :started_at, Ecto.Date
    field :finished_at, Ecto.Date
    belongs_to :equipment, Ewms.Equipment
    belongs_to :bucket, Ewms.Bucket

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:equipment_id, :bucket_id])
    |> validate_required([:equipment_id, :bucket_id])
  end
end
