defmodule Ewms.Repo.Migrations.AddPartIdToMeasurement do
  use Ecto.Migration

  def change do
    alter table(:measurements) do
      add :part_id, references(:parts, on_delete: :nothing, type: :binary_id)
    end
  end
end
