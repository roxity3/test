defmodule Ewms.Repo.Migrations.AddImageToProject do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :image, :string
    end
  end
end
