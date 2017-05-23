defmodule Ewms.Repo.Migrations.CreateBucket do
  use Ecto.Migration

  def change do
    create table(:buckets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :image, :string
      add :enabled, :boolean, default: false, null: false
      add :state_id, references(:states, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:buckets, [:state_id])
    create unique_index(:buckets, [:name])

  end
end
