defmodule Ewms.Repo.Migrations.CreateCondition do
  use Ecto.Migration

  def change do
    create table(:conditions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :enabled, :boolean, default: false, null: false

      timestamps()
    end
    create unique_index(:conditions, [:name])

  end
end
