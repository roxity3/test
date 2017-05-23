defmodule Ewms.Repo.Migrations.ChangeFieldsToProject do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      modify :started_at, :date
      modify :finished_at, :date
    end
  end
end
