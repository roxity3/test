defmodule Ewms.ComponentController do
  use Ewms.Web, :controller

  alias Ewms.Component
  alias Ewms.Border

  plug :load_borders when action in [:new, :create, :edit, :update]

  def load_borders(conn, _) do
    query =
      Border
      |> Border.alphabetical
      |> Border.names_and_ids
    borders = Repo.all query
    assign(conn, :borders, borders)
  end

  def index(conn, _params) do
    components = Repo.all(Component)
    render(conn, "index.html", components: components)
  end

  def new(conn, _params) do
    changeset = Component.changeset(%Component{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"component" => component_params}) do
    changeset = Component.changeset(%Component{}, component_params)

    case Repo.insert(changeset) do
      {:ok, _component} ->
        conn
        |> put_flash(:info, "Se creó correctamente el componente")
        |> redirect(to: component_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    component = Repo.get!(Component, id)
    render(conn, "show.html", component: component)
  end

  def edit(conn, %{"id" => id}) do
    component = Repo.get!(Component, id)
    changeset = Component.changeset(component)
    render(conn, "edit.html", component: component, changeset: changeset)
  end

  def update(conn, %{"id" => id, "component" => component_params}) do
    component = Repo.get!(Component, id)
    changeset = Component.changeset(component, component_params)

    case Repo.update(changeset) do
      {:ok, component} ->
        conn
        |> put_flash(:info, "Se actualizaron los datos del componente.")
        |> redirect(to: component_path(conn, :show, component))
      {:error, changeset} ->
        render(conn, "edit.html", component: component, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    component = Repo.get!(Component, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(component)

    conn
    |> put_flash(:info, "Se eliminó el componente.")
    |> redirect(to: component_path(conn, :index))
  end
end
