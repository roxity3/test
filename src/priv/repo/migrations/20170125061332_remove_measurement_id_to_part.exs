defmodule Ewms.Repo.Migrations.RemoveMeasurementIdToPart do
  use Ecto.Migration

  def change do
    alter table(:parts) do
      remove :measurement_id
    end
  end
end
