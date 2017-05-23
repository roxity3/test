defmodule Ewms.ProjectController do
  use Ewms.Web, :controller

  alias Ewms.Project
  alias Ewms.Customer

  # def action(conn, _) do
  #   customer = Repo.get!(Customer, conn.params["customer_id"])
  #   args = [conn, conn.params, customer]
  #   apply(__MODULE__, action_name(conn), args)
  # end

  def customer_projects(customer) do
    assoc(customer, :projects)
  end

  def index(conn, _params) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    projects = Repo.all(customer_projects(customer))
    render(conn, "index.html", customer: customer, projects: projects)
  end

  def new(conn, _params) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    changeset =
      customer
      |> build_assoc(:projects)
      |> Project.changeset()

    render(conn, "new.html", customer: customer, changeset: changeset)
  end

  def create(conn, %{"project" => project_params}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    changeset =
      customer
      |> build_assoc(:projects)
      |> Project.changeset(project_params)

    case Repo.insert(changeset) do
      {:ok, _project} ->
        conn
        |> put_flash(:info, "Se creó correctamente el proyecto.")
        |> redirect(to: customer_project_path(conn, :index, customer))
      {:error, changeset} ->
        render(conn, "new.html", customer: customer, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), id)
    render(conn, "show.html", customer: customer, project: project)
  end

  def edit(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), id)
    changeset = Project.changeset(project)
    render(conn, "edit.html", customer: customer, project: project, changeset: changeset)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), id)
    changeset = Project.changeset(project, project_params)

    case Repo.update(changeset) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Se actualizaron los datos del proyecto.")
        |> redirect(to: customer_project_path(conn, :show, customer, project))
      {:error, changeset} ->
        render(conn, "edit.html", customer: customer, project: project, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(project)

    conn
    |> put_flash(:info, "Se eliminó el proyecto.")
    |> redirect(to: customer_project_path(conn, :index, customer))
  end
end
