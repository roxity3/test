defmodule Ewms.Repo.Migrations.CreateBucketPart do
  use Ecto.Migration

  def change do
    create table(:buckets_parts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :initial_value, :decimal
      add :maxwear_value, :decimal
      add :bucket_id, references(:buckets, on_delete: :nothing, type: :binary_id)
      add :part_id, references(:parts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:buckets_parts, [:bucket_id])
    create index(:buckets_parts, [:part_id])

  end
end
