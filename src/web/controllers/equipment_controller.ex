defmodule Ewms.EquipmentController do
  use Ewms.Web, :controller

  alias Ewms.Model
  alias Ewms.Customer
  alias Ewms.Equipment

  plug :load_models when action in [:new, :create, :edit, :update]

  def load_models(conn, _) do
    query =
      Model
      |> Model.alphabetical
      |> Model.names_and_ids
    models = Repo.all query
    assign(conn, :models, models)
  end

  # def action(conn, _) do
  #   customer = Repo.get!(Customer, conn.params["customer_id"])
  #   project = Repo.get!(customer_projects(customer), conn.params["project_id"])
  #   args = [conn, conn.params, customer, project]
  #   apply(__MODULE__, action_name(conn), args)
  # end

  def customer_projects(customer) do
    assoc(customer, :projects)
  end

  def project_equipments(project) do
    assoc(project, :equipments)
  end

  def index(conn, _params) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    equipments =
      Repo.all(project_equipments(project))
      |> Repo.preload(:model)
    render(conn, "index.html", customer: customer, project: project, equipments: equipments)
  end

  def new(conn, _params) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    changeset =
      project
      |> build_assoc(:equipments)
      |> Equipment.changeset()

    render(conn, "new.html", customer: customer, project: project,changeset: changeset)
  end

  def create(conn, %{"equipment" => equipment_params}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    changeset =
      project
      |> build_assoc(:equipments)
      |> Equipment.changeset(equipment_params)

    case Repo.insert(changeset) do
      {:ok, _equipment} ->
        conn
        |> put_flash(:info, "Se creó correctamente el equipo")
        |> redirect(to: customer_project_equipment_path(conn, :index, customer, project))
      {:error, changeset} ->
        render(conn, "new.html", customer: customer, project: project, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    equipment =
      Repo.get!(project_equipments(project), id)
      |> Repo.preload(:model)
    render(conn, "show.html", customer: customer,
                  project: project, equipment: equipment)
  end

  def edit(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    equipment = Repo.get!(project_equipments(project), id)
    changeset = Equipment.changeset(equipment)
    render(conn, "edit.html", customer: customer,
                  project: project, equipment: equipment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "equipment" => equipment_params}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    equipment = Repo.get!(project_equipments(project), id)
    changeset = Equipment.changeset(equipment, equipment_params)

    case Repo.update(changeset) do
      {:ok, equipment} ->
        conn
        |> put_flash(:info, "Se actualizaron los datos del equipo.")
        |> redirect(to: customer_project_equipment_path(conn, :show, customer, project, equipment))
      {:error, changeset} ->
        render(conn, "edit.html", customer: customer, project: project, equipment: equipment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    equipment = Repo.get!(project_equipments(project), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(equipment)

    conn
    |> put_flash(:info, "Se eliminó el equipo.")
    |> redirect(to: customer_project_equipment_path(conn, :index, customer, project))
  end
end
