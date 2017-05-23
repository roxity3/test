defmodule Ewms.Repo.Migrations.AddStartedAtAndFinishedAtToMeasurement do
  use Ecto.Migration

  def change do
    alter table(:measurements) do
      add :started_at, :utc_datetime
      add :finished_at, :utc_datetime
    end
  end
end
