defmodule Ewms.Repo.Migrations.CreateKpi do
  use Ecto.Migration

  def change do
    create table(:kpis, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :limit, :decimal
      add :is_percentage, :boolean, default: false, null: false
      add :enabled, :boolean, default: false, null: false

      timestamps()
    end
    create unique_index(:kpis, [:name])

  end
end
