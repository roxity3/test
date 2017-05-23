defmodule Ewms.Repo.Migrations.CreatePart do
  use Ecto.Migration

  def change do
    create table(:parts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :codmid, :string
      add :codpn, :string
      add :codmine, :string
      add :price, :decimal
      add :enabled, :boolean, default: false, null: false
      add :system_id, references(:systems, on_delete: :nothing, type: :binary_id)
      add :component_id, references(:components, on_delete: :nothing, type: :binary_id)
      add :measurement_id, references(:measurements, on_delete: :nothing, type: :binary_id)
      add :condition_id, references(:conditions, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:parts, [:system_id])
    create index(:parts, [:component_id])
    create index(:parts, [:measurement_id])
    create index(:parts, [:condition_id])
    create unique_index(:parts, [:name])

  end
end
