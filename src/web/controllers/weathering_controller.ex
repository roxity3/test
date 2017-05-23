defmodule Ewms.WeatheringController do
  use Ewms.Web, :controller

  alias Ewms.Customer
  alias Ewms.Project
  alias Ewms.Equipment
  alias Ewms.Bucket
  alias Ewms.Get
  alias Ewms.Part
  alias Ewms.Component
  alias Ewms.Measurement
  alias Ewms.EquipmentBucket
  alias Ewms.Weathering

  def customer_projects(customer) do
    assoc(customer, :projects)
  end

  def project_equipments(project) do
    assoc(project, :equipments)
  end

  def equipment_buckets(equipment) do
    assoc(equipment, :equipments_buckets)
  end

  def index(conn, _params) do
    customers = Repo.all(Customer, order_by: :name)
    |> Repo.preload([:projects])
    render(conn, "index.html", customers: customers)
  end

  def projects(conn, %{"customer_id" => customer_id}) do
    customer = Repo.get!(Customer, customer_id)
    projects = Repo.all(customer_projects(customer))
    render(conn, "project/index.html", customer: customer, projects: projects)
  end

  def equipments(conn, %{"project_id" => project_id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(Project, project_id)
    equipments = Repo.all(project_equipments(project), order_by: :name)
    |> Repo.preload([:model])
    render(conn, "equipment/index.html", customer: customer, project: project, equipments: equipments)
  end

  def equipment_bucket(conn, %{"equipment_id" => equipment_id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(Project, conn.params["project_id"])
    equipment = Repo.get!(Equipment, conn.params["equipment_id"])
    |> Repo.preload([:model])

    equipment_bucket = Repo.get_by(EquipmentBucket, equipment_id: equipment_id)
    |> Repo.preload([:bucket])

    gets = Repo.all(Get, bucket_id: equipment_bucket.bucket.id)
    |> Repo.preload([:part])

    parts = for g <- gets, do:
          %{:label => "P",
            :part => g.part,
            :component => Repo.get!(Component, g.part.component_id),
            :measurement =>
              Repo.get_by(Measurement, part_id: g.part.id )
              |> Repo.preload(:magnitudes)}

    render(conn, "equipment_bucket/index.html", customer: customer,
                project: project, equipment: equipment,
                equipment_bucket: equipment_bucket,
                gets: gets,
                parts: parts)
  end

  def equipment_buckets(conn, %{"project_id" => project_id}) do
    project = Repo.get!(Project, project_id)
    equipments = Repo.all(project_equipments(project))
    equipments_buckets = Repo.all(equipment_buckets(equipments))
    |> Repo.preload([:bucket])
    # buckets = (from b in Bucket,
    #            join: eb in ^equipments_buckets, on:  eb.bucket_id == b.id) |> Repo.all

    render(conn, "equipment_bucket/index.html", equipments_buckets: equipments_buckets)
  end

  def update(conn, params) do
    customer = Repo.get!(Customer, params["customer_id"])
    project = Repo.get!(Project, params["project_id"])
    equipment = Repo.get!(Equipment, params["equipment_id"])
    part =  Repo.get!(Part, params["part_id"])
    bucket =  Repo.get!(Bucket, params["bucket_id"])
    measurement = Repo.get!(Measurement, params["measurement_id"])

    for {magnitude_id, amount} <- params["magnitudes"] do
      changeset = Weathering.changeset(%Weathering{},
                 %{customer_id: customer.id,
                   project_id: project.id,
                   equipment_id: equipment.id,
                   bucket_id: bucket.id,
                   part_id: part.id,
                   measurement_id: measurement.id,
                   magnitude_id: magnitude_id,
                   amount: amount,
                   registered_at: DateTime.to_date(DateTime.utc_now())}
      )
      case Repo.insert(changeset) do
        {:ok, _weathering} ->
          nil
        {:error, changeset} ->
          nil
      end
    end

    conn
    |> put_flash(:info, "Magnitudes actualizadas satisfactoriamente")
    |> redirect(to: weathering_path(conn, :equipment_bucket, customer, project, equipment))
  end
end
