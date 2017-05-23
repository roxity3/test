defmodule Ewms.Event do
  use Ewms.Web, :model

  schema "events" do
    field :name, :string
    field :enabled, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :enabled])
    |> validate_required([:name, :enabled])
  end
end
