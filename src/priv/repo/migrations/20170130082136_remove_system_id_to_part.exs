defmodule Ewms.Repo.Migrations.RemoveSystemIdToPart do
  use Ecto.Migration

  def change do
    alter table(:parts) do
      remove :system_id
    end
  end
end
