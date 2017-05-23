defmodule Ewms.Repo.Migrations.AddSystemIdToBucket do
  use Ecto.Migration

  def change do
    alter table(:buckets) do
        add :system_id, references(:systems, on_delete: :nothing, type: :binary_id)
    end
  end
end
