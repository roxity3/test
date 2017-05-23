defmodule Ewms.Repo.Migrations.RemoveEnabledToMeasurements do
  use Ecto.Migration

  def change do
    alter table(:measurements) do
      remove :enabled
    end
  end
end
