defmodule Ewms.Repo.Migrations.CreateBorder do
  use Ecto.Migration

  def change do
    create table(:borders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :label, :string

      timestamps()
    end

  end
end
