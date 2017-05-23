defmodule Ewms.Repo.Migrations.CreateMagnitude do
  use Ecto.Migration

  def change do
    create table(:magnitudes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :initial, :decimal
      add :maximum, :decimal
      add :enabled, :boolean, default: false, null: false
      add :measurement_id, references(:measurements, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create unique_index(:magnitudes, [:measurement_id, :name])

  end
end
