defmodule Ewms.Model do
  use Ewms.Web, :model
  use Arc.Ecto.Schema

  schema "models" do
    field :name, :string
    field :image, Ewms.ImageUploader.Type
    field :enabled, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :enabled], [:image])
    |> cast_attachments(params, [:image])
    |> validate_required([:name, :enabled])
    |> unique_constraint(:name)
  end

  def alphabetical(query) do
    from m in query, order_by: m.name
  end

  def names_and_ids(query) do
    from m in query, select: {m.name, m.id}
  end
end
