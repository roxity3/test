defmodule Ewms.Repo.Migrations.RemovePositionToGets do
  use Ecto.Migration

  def change do
    alter table(:gets) do
      remove :position
    end
  end
end
