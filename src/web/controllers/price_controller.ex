defmodule Ewms.PriceController do
  use Ewms.Web, :controller

  alias Ewms.Part
  alias Ewms.Price

  def part_prices(part) do
    assoc(part, :prices)
  end

  def index(conn, _params) do
    part = Repo.get!(Part, conn.params["part_id"])
    prices = Repo.all(part_prices(part))
    render(conn, "index.html", part: part, prices: prices)
  end

  def new(conn, _params) do
    part = Repo.get!(Part, conn.params["part_id"])
    changeset =
      part
      |> build_assoc(:prices)
      |> Price.changeset()
    render(conn, "new.html", part: part, changeset: changeset)
  end

  def create(conn, %{"price" => price_params}) do
    part = Repo.get!(Part, conn.params["part_id"])
    changeset =
      part
      |> build_assoc(:prices)
      |> Price.changeset(price_params)

    case Repo.insert(changeset) do
      {:ok, _price} ->
        conn
        |> put_flash(:info, "Price created successfully.")
        |> redirect(to: part_price_path(conn, :index, @part))
      {:error, changeset} ->
        render(conn, "new.html", part: part, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    part = Repo.get!(Part, conn.params["part_id"])
    price = Repo.get!(part_prices(part), id)
    render(conn, "show.html", part: part, price: price)
  end

  def edit(conn, %{"id" => id}) do
    part = Repo.get!(Part, conn.params["part_id"])
    price = Repo.get!(part_prices(part), id)
    changeset = Price.changeset(price)
    render(conn, "edit.html", part: part, price: price, changeset: changeset)
  end

  def update(conn, %{"id" => id, "price" => price_params}) do
    part = Repo.get!(Part, conn.params["part_id"])
    price = Repo.get!(part_prices(part), id)
    changeset = Price.changeset(price, price_params)

    case Repo.update(changeset) do
      {:ok, price} ->
        conn
        |> put_flash(:info, "Price updated successfully.")
        |> redirect(to: part_price_path(conn, :show, price))
      {:error, changeset} ->
        render(conn, "edit.html", part: part, price: price, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    part = Repo.get!(Part, conn.params["part_id"])
    price = Repo.get!(part_prices(part), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(price)

    conn
    |> put_flash(:info, "Price deleted successfully.")
    |> redirect(to: part_price_path(conn, :index, @part))
  end
end
