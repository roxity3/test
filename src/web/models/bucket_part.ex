defmodule Ewms.BucketPart do
  use Ewms.Web, :model

  @primary_key false
  schema "buckets_parts" do
    belongs_to :bucket, Ewms.Bucket
    belongs_to :part, Ewms.Part

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:bucket_id, :part_id])
    |> validate_required([:bucket_id, :part_id])
  end
end
