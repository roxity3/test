defmodule Ewms.Repo.Migrations.AddPositionToGets do
  use Ecto.Migration

  def change do
    alter table(:gets) do
      add :position, :integer
    end
    create unique_index(:gets, [:id, :position])
  end
end
