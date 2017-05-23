defmodule Ewms.Repo.Migrations.CreateComponent do
  use Ecto.Migration

  def change do
    create table(:components, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :measurabled, :boolean, default: false, null: false
      add :enabled, :boolean, default: false, null: false

      timestamps()
    end
    create unique_index(:components, [:name])

  end
end
