defmodule Ewms.Customer do
  use Ewms.Web, :model
  use Arc.Ecto.Schema

  schema "customers" do
    field :name, :string
    field :image, Ewms.ImageUploader.Type
    field :enabled, :boolean, default: false
    has_many :projects, Ewms.Project

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :image, :enabled])
    |> cast_attachments(params, [:image])
    |> validate_required([:name, :image, :enabled])
    |> unique_constraint(:name)
  end
end
