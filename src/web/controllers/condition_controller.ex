defmodule Ewms.ConditionController do
  use Ewms.Web, :controller
  #use Guardian.Phoenix.Controller

  #plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__, typ: "access"
  #plug Guardian.Plug.EnsurePermissions, handler: __MODULE__, default: [:read, :write]

  alias Ewms.Condition

  def index(conn, _params) do
    conditions = Repo.all(Condition)
    render(conn, "index.html", conditions: conditions)
  end

  def new(conn, _params) do
    changeset = Condition.changeset(%Condition{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"condition" => condition_params}) do
    changeset = Condition.changeset(%Condition{}, condition_params)

    case Repo.insert(changeset) do
      {:ok, _condition} ->
        conn
        |> put_flash(:info, "Se creó correctamente la condición del bucket.")
        |> redirect(to: condition_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    condition = Repo.get!(Condition, id)
    render(conn, "show.html", condition: condition)
  end

  def edit(conn, %{"id" => id}) do
    condition = Repo.get!(Condition, id)
    changeset = Condition.changeset(condition)
    render(conn, "edit.html", condition: condition, changeset: changeset)
  end

  def update(conn, %{"id" => id, "condition" => condition_params}) do
    condition = Repo.get!(Condition, id)
    changeset = Condition.changeset(condition, condition_params)

    case Repo.update(changeset) do
      {:ok, condition} ->
        conn
        |> put_flash(:info, "Se editaron los datos de la condición del bucket.")
        |> redirect(to: condition_path(conn, :show, condition))
      {:error, changeset} ->
        render(conn, "edit.html", condition: condition, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    condition = Repo.get!(Condition, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(condition)

    conn
    |> put_flash(:info, "Se eliminó la condición del bucket.")
    |> redirect(to: condition_path(conn, :index))
  end

  # The unauthenticated function is called because this controller has been
  # specified as the handler.
  # def unauthenticated(conn, _params) do
  #   conn
  #   |> put_flash(:error, "Authentication required")
  #   |> redirect(to: auth_path(conn, :login, :identity))
  # end
  #
  # def unauthorized(conn, _params) do
  #   conn
  #   |> put_flash(:error, "Unauthorized")
  #   |> redirect(external: redirect_back(conn))
  # end
end
