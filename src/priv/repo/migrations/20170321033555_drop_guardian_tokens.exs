defmodule Ewms.Repo.Migrations.DropGuardianTokens do
  use Ecto.Migration

  def change do
    drop_if_exists table(:guardian_tokens)
  end
end
