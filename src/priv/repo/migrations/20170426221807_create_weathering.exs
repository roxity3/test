defmodule Ewms.Repo.Migrations.CreateWeathering do
  use Ecto.Migration

  def change do
    create table(:weatherings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :registered_at, :date
      add :amount, :decimal
      add :customer_id, references(:customers, on_delete: :nothing, type: :binary_id)
      add :project_id, references(:projects, on_delete: :nothing, type: :binary_id)
      add :equipment_id, references(:equipments, on_delete: :nothing, type: :binary_id)
      add :bucket_id, references(:buckets, on_delete: :nothing, type: :binary_id)
      add :part_id, references(:parts, on_delete: :nothing, type: :binary_id)
      add :measurement_id, references(:measurements, on_delete: :nothing, type: :binary_id)
      add :magnitude_id, references(:magnitudes, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:weatherings, [:customer_id])
    create index(:weatherings, [:project_id])
    create index(:weatherings, [:equipment_id])
    create index(:weatherings, [:bucket_id])
    create index(:weatherings, [:part_id])
    create index(:weatherings, [:measurement_id])
    create index(:weatherings, [:magnitude_id])

  end
end
