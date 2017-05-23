defmodule Ewms.Repo.Migrations.CreateUnit do
  use Ecto.Migration

  def change do
    create table(:units, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :symbol, :string, null: false
      add :enabled, :boolean, default: false, null: false

      timestamps()
    end
    create unique_index(:units, [:name])
    create unique_index(:units, [:symbol])

  end
end
