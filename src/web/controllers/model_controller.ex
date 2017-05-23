defmodule Ewms.ModelController do
  use Ewms.Web, :controller

  alias Ewms.Model

  def index(conn, _params) do
    models = Repo.all(Model)
    render(conn, "index.html", models: models)
  end

  def new(conn, _params) do
    changeset = Model.changeset(%Model{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"model" => model_params}) do
    changeset = Model.changeset(%Model{}, model_params)

    case Repo.insert(changeset) do
      {:ok, _model} ->
        conn
        |> put_flash(:info, "Se creo correctamente el modelo de equipo.")
        |> redirect(to: model_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    model = Repo.get!(Model, id)
    render(conn, "show.html", model: model)
  end

  def edit(conn, %{"id" => id}) do
    model = Repo.get!(Model, id)
    changeset = Model.changeset(model)
    render(conn, "edit.html", model: model, changeset: changeset)
  end

  def update(conn, %{"id" => id, "model" => model_params}) do
    model = Repo.get!(Model, id)
    changeset = Model.changeset(model, model_params)

    case Repo.update(changeset) do
      {:ok, model} ->
        conn
        |> put_flash(:info, "Se editaron los datos del modelo de equipo.")
        |> redirect(to: model_path(conn, :show, model))
      {:error, changeset} ->
        render(conn, "edit.html", model: model, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    model = Repo.get!(Model, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(model)

    conn
    |> put_flash(:info, "Se eliminó el modelo de equipo.")
    |> redirect(to: model_path(conn, :index))
  end
end
