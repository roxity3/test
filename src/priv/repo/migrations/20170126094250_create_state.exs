defmodule Ewms.Repo.Migrations.CreateState do
  use Ecto.Migration

  def change do
    create table(:states, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :enabled, :boolean, default: false, null: false

      timestamps()
    end
    create unique_index(:states, [:name])
  end
end
