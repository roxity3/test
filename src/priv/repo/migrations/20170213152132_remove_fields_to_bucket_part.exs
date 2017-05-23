defmodule Ewms.Repo.Migrations.RemoveFieldsToBucketPart do
  use Ecto.Migration

  def change do
    alter table(:buckets_parts) do
      remove :initial_value
      remove :maxwear_value
    end
  end
end
