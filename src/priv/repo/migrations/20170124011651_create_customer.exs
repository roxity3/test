defmodule Ewms.Repo.Migrations.CreateCustomer do
  use Ecto.Migration

  def change do
    create table(:customers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :image, :string
      add :enabled, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:customers, [:name])
  end
end
