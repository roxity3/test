defmodule Ewms.Repo.Migrations.AddUserIdToWeathering do
  use Ecto.Migration

  def change do
    alter table(:weatherings) do
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
    end
    create unique_index(:weatherings, [:user_id])
  end
end
