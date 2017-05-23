defmodule Ewms.Repo.Migrations.RemoveConditionIdToPart do
  use Ecto.Migration

  def change do
    alter table(:parts) do
      remove :condition_id
    end
  end
end
