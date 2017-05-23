defmodule Ewms.Repo.Migrations.CreateMeasurement do
  use Ecto.Migration

  def change do
    create table(:measurements, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :image, :string
      add :enabled, :boolean, default: false, null: false

      timestamps()
    end
    create unique_index(:measurements, [:name])

  end
end
