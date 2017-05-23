defmodule Ewms.GetController do
  use Ewms.Web, :controller

  alias Ewms.Part
  alias Ewms.Bucket
  alias Ewms.Project
  alias Ewms.Customer
  alias Ewms.Get

  plug :load_parts when action in [:new, :create, :edit, :update]

  def load_parts(conn, _) do
    query =
      Part
      |> Part.alphabetical
      |> Part.names_and_ids
    parts = Repo.all query
    assign(conn, :parts, parts)
  end

  def customer_projects(customer) do
    assoc(customer, :projects)
  end

  def project_buckets(project) do
    assoc(project, :buckets)
  end

  def bucket_gets(bucket) do
    assoc(bucket, :gets)
  end

  def index(conn, _params) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    bucket = Repo.get!(project_buckets(project), conn.params["bucket_id"])
    gets =
      Repo.all(bucket_gets(bucket))
      |> Repo.preload(:part)
    render(conn, "index.html",
                customer: customer, project: project, bucket: bucket, gets: gets)
  end

  def new(conn, _params) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    bucket = Repo.get!(project_buckets(project), conn.params["bucket_id"])
    changeset =
      bucket
      |> build_assoc(:gets)
      |> Get.changeset()
    render(conn, "new.html", 
            customer: customer, project: project, bucket: bucket, changeset: changeset)
  end

  def create(conn, %{"get" => get_params}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    bucket = Repo.get!(project_buckets(project), conn.params["bucket_id"])
    changeset =
      bucket
      |> build_assoc(:gets)
      |> Get.changeset(get_params)

    case Repo.insert(changeset) do
      {:ok, _get} ->
        conn
        |> put_flash(:info, "Get created successfully.")
        |> redirect(to: customer_project_bucket_get_path(conn, :index, customer, project, bucket))
      {:error, changeset} ->
        render(conn, "new.html",
                customer: customer, project: project, bucket: bucket, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    bucket = Repo.get!(project_buckets(project), conn.params["bucket_id"])
    get = Repo.get!(bucket_gets(bucket), id)
    render(conn, "show.html",
          customer: customer, project: project, bucket: bucket, get: get)
  end

  def edit(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    bucket = Repo.get!(project_buckets(project), conn.params["bucket_id"])
    get = Repo.get!(bucket_gets(bucket), id)
    changeset = Get.changeset(get)
    render(conn, "edit.html",
              customer: customer, project: project, bucket: bucket, get: get, changeset: changeset)
  end

  def update(conn, %{"id" => id, "get" => get_params}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    bucket = Repo.get!(project_buckets(project), conn.params["bucket_id"])
    get = Repo.get!(bucket_gets(bucket), id)
    changeset = Get.changeset(get, get_params)

    case Repo.update(changeset) do
      {:ok, get} ->
        conn
        |> put_flash(:info, "Get updated successfully.")
        |> redirect(to: customer_project_bucket_get_path(conn, :show, customer, project, bucket, get))
      {:error, changeset} ->
        render(conn, "edit.html",
                  customer: customer, project: project, bucket: bucket, get: get, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Repo.get!(Customer, conn.params["customer_id"])
    project = Repo.get!(customer_projects(customer), conn.params["project_id"])
    bucket = Repo.get!(project_buckets(project), conn.params["bucket_id"])
    get = Repo.get!(bucket_gets(bucket), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(get)

    conn
    |> put_flash(:info, "Get deleted successfully.")
    |> redirect(to: customer_project_bucket_get_path(conn, :index, customer, project, bucket))
  end
end
