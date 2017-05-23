defmodule Ewms.Repo.Migrations.AddProjectIdToBucket do
  use Ecto.Migration

  def change do
    alter table(:buckets) do
      add :project_id, references(:projects, on_delete: :nothing, type: :binary_id)
    end
  end
end
