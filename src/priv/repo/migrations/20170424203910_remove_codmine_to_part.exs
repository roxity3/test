defmodule Ewms.Repo.Migrations.RemoveCodmineToPart do
  use Ecto.Migration

  def change do
    alter table(:parts) do
      remove :codmine
    end
  end
end
