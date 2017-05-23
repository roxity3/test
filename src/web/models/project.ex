defmodule Ewms.Project do
  use Ewms.Web, :model
  use Arc.Ecto.Schema

  # @derive {Poison.Encoder, only: [
  #     :name,
  #     :started_at,
  #     :finished_at,
  #     :image,
  #     :customer_id
  #   ]}
  schema "projects" do
    field :name, :string
    field :started_at, Ecto.Date
    field :finished_at, Ecto.Date
    field :image, Ewms.ImageUploader.Type
    belongs_to :customer, Ewms.Customer
    has_many :buckets, Ewms.Bucket
    has_many :equipments, Ewms.Equipment
    has_many :prices, Ewms.Price

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  |> validate_required([:name, :started_at])
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name],[:image,:started_at, :finished_at])
    |> cast_attachments(params, [:image])
    |> unique_constraint(:name)
  end
end
