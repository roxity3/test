defmodule Ewms.Repo.Migrations.RemovePriceToPart do
  use Ecto.Migration

  def change do
    alter table(:parts) do
      remove :price
    end
  end
end
