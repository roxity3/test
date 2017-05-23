defmodule Ewms.Weathering do
  use Ewms.Web, :model

  schema "weatherings" do
    field :registered_at, Ecto.Date
    field :amount, :decimal
    belongs_to :customer, Ewms.Customer
    belongs_to :project, Ewms.Project
    belongs_to :equipment, Ewms.Equipment
    belongs_to :bucket, Ewms.Bucket
    belongs_to :part, Ewms.Part
    belongs_to :measurement, Ewms.Measurement
    belongs_to :magnitude, Ewms.Magnitude
    belongs_to :user, Ewms.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:registered_at, :amount,
                     :customer_id, :project_id,
                     :equipment_id, :bucket_id,
                     :part_id, :measurement_id,
                     :magnitude_id,
                     :user_id])
    |> validate_required([:registered_at, :user_id])
  end
end
