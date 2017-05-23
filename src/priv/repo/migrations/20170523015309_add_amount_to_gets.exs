defmodule Ewms.Repo.Migrations.AddAmountToGets do
  use Ecto.Migration

  def change do
    alter table(:gets) do
      add :amount, :integer
    end
  end
end
