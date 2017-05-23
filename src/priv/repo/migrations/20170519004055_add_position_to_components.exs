defmodule Ewms.Repo.Migrations.AddPositionToComponents do
  use Ecto.Migration

  def change do
    alter table(:components) do
      add :position, :integer
    end
    create unique_index(:components, [:id, :position])
  end
end
