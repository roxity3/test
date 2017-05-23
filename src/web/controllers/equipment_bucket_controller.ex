defmodule Ewms.EquipmentBucketController do
  use Ewms.Web, :controller

  alias Ewms.Customer
  alias Ewms.Project
  alias Ewms.Equipment
  alias Ewms.EquipmentBucket
  alias Ewms.Bucket

  plug :load_buckets when action in [:new, :create, :edit, :update]

  def load_buckets(conn, _) do
    query =
      Bucket
      |> Bucket.alphabetical
      |> Bucket.names_and_ids
    buckets = Repo.all query
    assign(conn, :buckets, buckets)
  end

  def equipment_equipments_buckets(equipment) do
    assoc(equipment, :equipments_buckets)
  end

  def index(conn, _params) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(Project, conn.params["project_id"])
    equipment = Repo.get!(Equipment, conn.params["equipment_id"])
    equipments_buckets =
      Repo.all(equipment_equipments_buckets(equipment))
      |> Repo.preload([:bucket])
    render(conn, "index.html", customer: customer, project: project,
                  equipment: equipment, equipments_buckets: equipments_buckets)
  end

  def new(conn, _params) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(Project, conn.params["project_id"])
    equipment = Repo.get!(Equipment, conn.params["equipment_id"])
    changeset =
      equipment
      |> build_assoc(:equipments_buckets)
      |> EquipmentBucket.changeset()
    render(conn, "new.html", customer: customer, project: project,
                  equipment: equipment, changeset: changeset)
  end

  def create(conn, %{"equipment_bucket" => equipment_bucket_params}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(Project, conn.params["project_id"])
    equipment = Repo.get!(Equipment, conn.params["equipment_id"])
    changeset =
      equipment
      |> build_assoc(:equipments_buckets)
      |> EquipmentBucket.changeset(equipment_bucket_params)

    case Repo.insert(changeset) do
      {:ok, _equipment_bucket} ->
        conn
        |> put_flash(:info, "Se creó correctamente bucket del equipo.")
        |> redirect(to: customer_project_equipment_equipment_bucket_path(
                    conn, :index, customer, project, equipment))
      {:error, changeset} ->
        render(conn, "new.html", customer: customer, project: project,
                     equipment: equipment, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(Project, conn.params["project_id"])
    equipment = Repo.get!(Equipment, conn.params["equipment_id"])
    equipment_bucket = Repo.get!(equipment_equipments_buckets(equipment), id)
    render(conn, "show.html", customer: customer, project: project,
                 equipment: equipment, equipment_bucket: equipment_bucket)
  end

  def edit(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(Project, conn.params["project_id"])
    equipment = Repo.get!(Equipment, conn.params["equipment_id"])
    equipment_bucket = Repo.get!(equipment_equipments_buckets(equipment), id)
    changeset = EquipmentBucket.changeset(equipment_bucket)
    render(conn, "edit.html", customer: customer, project: project,
                equipment: equipment, equipment_bucket: equipment_bucket,
                changeset: changeset)
  end

  def update(conn, %{"id" => id, "equipment_bucket" => equipment_bucket_params}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(Project, conn.params["project_id"])
    equipment = Repo.get!(Equipment, conn.params["equipment_id"])
    equipment_bucket = Repo.get!(equipment_equipments_buckets(equipment), id)
    changeset = EquipmentBucket.changeset(equipment_bucket, equipment_bucket_params)

    case Repo.update(changeset) do
      {:ok, equipment_bucket} ->
        conn
        |> put_flash(:info, "Se actualizaron los datos de bucket del equipo.")
        |> redirect(to: customer_project_equipment_equipment_bucket_path(conn, :show,
                    customer, project, equipment, equipment_bucket))
      {:error, changeset} ->
        render(conn, "edit.html", customer: customer, project: project,
                     equipment: equipment, equipment_bucket: equipment_bucket,
                     changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(Project, conn.params["project_id"])
    equipment = Repo.get!(Equipment, conn.params["equipment_id"])
    equipment_bucket = Repo.get!(equipment_equipments_buckets(equipment), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(equipment_bucket)

    conn
    |> put_flash(:info, "Se eliminó bucket del equipo.")
    |> redirect(to: customer_project_equipment_equipment_bucket_path(conn, :index,
                customer, project, equipment))
  end
end
