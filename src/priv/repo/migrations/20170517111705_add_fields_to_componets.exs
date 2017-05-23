defmodule Ewms.Repo.Migrations.AddFieldsToComponets do
  use Ecto.Migration

  def change do
    alter table(:components) do
      add :border_id, references(:borders, on_delete: :delete_all, type: :binary_id)
    end
    create unique_index(:components, [:border_id])
  end
end
