defmodule Ewms.Get do
  use Ewms.Web, :model

  schema "gets" do
    field :amount, :integer
    belongs_to :bucket, Ewms.Bucket
    belongs_to :part, Ewms.Part

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount, :bucket_id, :part_id])
    |> validate_required([:amount, :bucket_id, :part_id])
  end
end
