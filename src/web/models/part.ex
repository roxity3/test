defmodule Ewms.Part do
  use Ewms.Web, :model

  schema "parts" do
    field :name, :string
    field :codmid, :string
    field :codpn, :string
    field :enabled, :boolean, default: false
    belongs_to :component, Ewms.Component
    many_to_many :buckets, Ewms.Bucket, join_through: "buckets_parts"
    has_many :measurements, Ewms.Measurement
    has_many :prices, Ewms.Price

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :codmid, :codpn, :enabled],
            [:component_id])
    |> validate_required([:name, :codmid, :codpn, :enabled])
    |> unique_constraint(:name)
  end

  def alphabetical(query) do
    from p in query, order_by: p.name
  end

  def names_and_ids(query) do
    from p in query, select: {p.name, p.id}
  end
end
