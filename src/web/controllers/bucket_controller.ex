defmodule Ewms.BucketController do
  use Ewms.Web, :controller

  alias Ewms.Customer
  alias Ewms.System
  alias Ewms.State
  alias Ewms.Bucket

  plug :load_systems when action in [:new, :create, :edit, :update]
  plug :load_states when action in [:new, :create, :edit, :update]

  def load_systems(conn, _) do
    query =
      System
      |> System.alphabetical
      |> System.names_and_ids
    systems = Repo.all query
    assign(conn, :systems, systems)
  end

  def load_states(conn, _) do
    query =
      State
      |> State.alphabetical
      |> State.names_and_ids
    states = Repo.all query
    assign(conn, :states, states)
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

  def project_buckets(project) do
    assoc(project, :buckets)
  end

  def index(conn, _params) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    buckets =
      Repo.all(project_buckets(project))
      |> Repo.preload([:system, :state])
    render(conn, "index.html", customer: customer, project: project, buckets: buckets)
  end

  def new(conn, _params) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    changeset =
      project
      |> build_assoc(:buckets)
      |> Bucket.changeset()
    render(conn, "new.html", customer: customer, project: project, changeset: changeset)
  end

  def create(conn, %{"bucket" => bucket_params}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    changeset =
      project
      |> build_assoc(:buckets)
      |> Bucket.changeset(bucket_params)

    case Repo.insert(changeset) do
      {:ok, _bucket} ->
        conn
        |> put_flash(:info, "Se creó correctamente el bucket.")
        |> redirect(to: customer_project_bucket_path(conn, :index, customer, project))
      {:error, changeset} ->
        render(conn, "new.html", customer: customer, project: project, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    bucket =
      Repo.get!(project_buckets(project), id)
      |> Repo.preload([:system, :state])
    render(conn, "show.html", customer: customer, project: project, bucket: bucket)
  end

  def edit(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    bucket = Repo.get!(project_buckets(project), id)
    changeset = Bucket.changeset(bucket)
    render(conn, "edit.html", customer: customer, project: project, bucket: bucket, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bucket" => bucket_params}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    bucket = Repo.get!(project_buckets(project), id)
    changeset = Bucket.changeset(bucket, bucket_params)

    case Repo.update(changeset) do
      {:ok, bucket} ->
        conn
        |> put_flash(:info, "Se actualizaron los datos del bucket.")
        |> redirect(to: customer_project_bucket_path(conn, :show, customer, project, bucket))
      {:error, changeset} ->
        render(conn, "edit.html", customer: customer, project: project, bucket: bucket, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    bucket = Repo.get!(project_buckets(project), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(bucket)

    conn
    |> put_flash(:info, "Se eliminó el bucket.")
    |> redirect(to: customer_project_bucket_path(conn, :index, customer, project))
  end
end
