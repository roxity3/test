defmodule Ewms.User do
  use Ewms.Web, :model

  alias Comeonin.Bcrypt

  alias Ewms.Repo

  schema "users" do
    field :name, :string
    field :email, :string
    field :username, :string
    field :password_hash, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    field :is_admin, :boolean

    has_many :authorizations, Ewms.Authorization

    timestamps()
  end

  @required_fields ~w(email name username is_admin)a
  @optional_fields ~w()a

  def registration_changeset(model, params \\ %{}) do
    model
    |>cast(params, ~w(email name username password is_admin)a)
    |> validate_required(@required_fields)
    |> validate_length(:username, min: 1, max: 20)
    |> validate_length(:password, min: 6, max: 100)

    |> cast(params, [:name, :username, :password, :password_confirmation, :is_admin])
    |> validate_required([:name, :username, :password, :password_confirmation, :is_admin])
    |> validate_length(:username, min: 6, max: 20)
    |> validate_length(:password, min: 8, max: 12)
    |> validate_confirmation(:password)
    |> hash_password()
    |> unique_constraint(:username)
  end

  defp hash_password(%{valid?: false} = changeset), do: changeset
  defp hash_password(%{valid?: true} = changeset) do
    hashed_password =
      changeset
      |> get_field(:password)
      |> Bcrypt.hashpwsalt()

    changeset
    |> put_change(:password_hash, hashed_password)
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:username, min: 1, max: 20)
  end

  def make_admin!(user) do
    user
    |> cast(%{is_admin: true}, ~w(is_admin)a)
    |> Repo.update!
  end
end
