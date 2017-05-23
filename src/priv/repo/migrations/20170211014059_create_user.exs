defmodule Ewms.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    # create table(:users, primary_key: false) do
    #   add :id, :binary_id, primary_key: true
    #   add :name, :string
    #   add :username, :string
    #   add :password_hash, :string
    #
    #   timestamps()
    # end
    # create unique_index(:users, [:username])
    execute("CREATE EXTENSION IF NOT EXISTS citext;")

    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :citext

      timestamps()
    end

    create index(:users, [:email], unique: true)
  end
end
