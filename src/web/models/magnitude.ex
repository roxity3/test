defmodule Ewms.Magnitude do
  use Ewms.Web, :model

  schema "magnitudes" do
    field :name, :string
    field :initial, :decimal
    field :maximum, :decimal
    field :enabled, :boolean, default: false
    belongs_to :measurement, Ewms.Measurement

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :initial, :maximum, :enabled], [:measurement_id])
    |> validate_required([:name, :initial, :maximum, :enabled])
    |> unique_constraint(:name)
  end
end
