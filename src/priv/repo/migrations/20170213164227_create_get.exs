defmodule Ewms.Repo.Migrations.CreateGet do
  use Ecto.Migration

  def change do
    create table(:gets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :bucket_id, references(:buckets, on_delete: :nothing, type: :binary_id)
      add :part_id, references(:parts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:gets, [:bucket_id])
    create index(:gets, [:part_id])

  end
end
