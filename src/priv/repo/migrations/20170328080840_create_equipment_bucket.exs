defmodule Ewms.Repo.Migrations.CreateEquipmentBucket do
  use Ecto.Migration

  def change do
    create table(:equipments_buckets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :started_at, :date
      add :finished_at, :date
      add :equipment_id, references(:equipments, on_delete: :nothing, type: :binary_id)
      add :bucket_id, references(:buckets, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:equipments_buckets, [:equipment_id])
    create index(:equipments_buckets, [:bucket_id])

  end
end
