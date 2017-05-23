defmodule Ewms.Repo.Migrations.CreatePrice do
  use Ecto.Migration

  def change do
    create table(:prices, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :started_at, :date
      add :finished_at, :date
      add :amount, :decimal
      add :project_id, references(:projects, on_delete: :nothing, type: :binary_id)
      add :part_id, references(:parts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:prices, [:project_id])
    create index(:prices, [:part_id])

  end
end
