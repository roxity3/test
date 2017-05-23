defmodule Ewms.Repo.Migrations.CreateEquipment do
  use Ecto.Migration

  def change do
    create table(:equipments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :enabled, :boolean, default: false, null: false
      add :project_id, references(:projects, on_delete: :nothing, type: :binary_id)
      add :model_id, references(:models, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:equipments, [:project_id])
    create index(:equipments, [:model_id])
    create unique_index(:equipments, [:name])

  end
end
