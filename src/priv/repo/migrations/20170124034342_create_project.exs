defmodule Ewms.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :started_at, :datetime
      add :finished_at, :datetime
      add :customer_id, references(:customers, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:projects, [:customer_id])
    create unique_index(:projects, [:name])

  end
end
