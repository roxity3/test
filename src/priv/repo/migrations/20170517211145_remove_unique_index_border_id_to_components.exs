defmodule Ewms.Repo.Migrations.RemoveUniqueIndexBorderIdToComponents do
  use Ecto.Migration

  def change do
    drop unique_index(:components, [:border_id])
  end
end
