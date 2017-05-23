defmodule Ewms.Measurement do
  use Ewms.Web, :model
  use Arc.Ecto.Schema

  schema "measurements" do
    field :name, :string
    field :image, Ewms.ImageUploader.Type
    field :started_at, Ecto.DateTime
    field :finished_at, Ecto.DateTime
    belongs_to :part, Ewms.Part
    has_many :magnitudes, Ewms.Magnitude

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :image, :part_id])
    |> cast_attachments(params, [:image])
    |> validate_required([:name, :image, :part_id])
    |> unique_constraint(:name)
  end

  def alphabetical(query) do
    from m in query, order_by: m.name
  end

  def names_and_ids(query) do
    from m in query, select: {m.name, m.id}
  end
end
