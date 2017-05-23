defmodule Ewms.Repo.Migrations.AddImageToModel do
  use Ecto.Migration

  def change do
    alter table(:models) do
      add :image, :string
    end
  end
end
