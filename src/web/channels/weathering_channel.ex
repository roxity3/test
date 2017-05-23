defmodule Ewms.WeatheringChannel do
  use Ewms.Web, :channel

  alias Ewms.Customer
  alias Ewms.Project
  alias Ewms.Equipment
  alias Ewms.Bucket
  alias Ewms.EquipmentBucket
  alias Ewms.Get
  alias Ewms.Component
  alias Ewms.Measurement
  alias Ewms.Border

  def customer_projects(customer) do
    assoc(customer, :projects)
  end

  def join("weathering:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (weathering:lobby).
  def handle_in("get_projects", %{"customer_id" => customer_id}, socket) do
    customer = Repo.get!(Customer, customer_id)
    |> Repo.preload(:projects)
    projects =
      customer.projects
      |> Enum.map(fn(p)->%{
          :id => p.id,
          :name => p.name,
          :image =>p.image
          }
        end)

    html = Phoenix.View.render_to_string(
            Ewms.WeatheringView, "select_projects.html", projects: projects)

    broadcast socket, "populate_projects", %{html: html}
    {:noreply, socket}
  end

  def handle_in("get_equipments", %{"project_id" => project_id}, socket) do
    project = Repo.get!(Project, project_id)
    |> Repo.preload([:equipments])
    |> Repo.preload(equipments: :model)

    equipments =
      project.equipments
      |> Enum.map( fn(e)->%{
          :id => e.id,
          :name => e.name,
          :image => e.model.image
          }
        end)

    html = Phoenix.View.render_to_string(
            Ewms.WeatheringView, "select_equipments.html", equipments: equipments)

    broadcast socket, "populate_equipments", %{html: html}
    {:noreply, socket}
  end

  def handle_in("get_bucket", %{"equipment_id" => equipment_id}, socket) do

    equipment =
      Equipment
      |> Repo.get!(equipment_id)
      |> Repo.preload([:model])

    equipment_bucket =
      EquipmentBucket
      |> Repo.get_by(equipment_id: equipment_id)
      |> Repo.preload([:bucket])

    gets =
      Get
      |> Repo.all(bucket_id: equipment_bucket.bucket.id)
      |> Repo.preload(:part)
      |> Repo.preload(part: :component)
      |> Enum.filter(fn (g)-> g.part.component.measurabled == true end)


    gets
    |> Enum.map(fn (g)-> IO.puts(g.part.name) end)

    borders =
      Border
      |> Repo.all()

    components =
      Component
      |> Repo.all(order_by: [:id, :position])
      |> Repo.preload(:border)
      |> Enum.filter(fn (c)-> not is_nil(c.border_id) end)
      |> Enum.filter(fn (c)-> (c.measurabled) == true end)

    parts =
      gets
      |> Enum.map(fn (g)->%{
          :label => to_string(g.amount),
          :amount => g.amount,
          :range => 1..g.amount,
          :part =>  g.part,
          :component =>
            Component
            |> Repo.get!(g.part.component_id)
            |> Repo.preload(:border),
          :measurement =>
            Measurement
            |> Repo.get_by(part_id: g.part.id )
            |> Repo.preload(:magnitudes)
          }
        end)

      # for g <- gets, do:
      #       %{:label => "P",
      #         :part =>  g.part,
      #         :component => Repo.get!(Component, g.part.component_id)
      #                       |> Repo.preload(:border),
      #         :measurement =>
      #           Repo.get_by(Measurement, part_id: g.part.id )
      #           |> Repo.preload(:magnitudes)}

    border_left =
      parts
      |> Enum.filter(fn p -> p.component.border.label == "left" end)

    border_right =
      parts
      |> Enum.filter(fn p -> p.component.border.label == "right" end)

    border_top =
      parts
      |> Enum.filter(fn p -> p.component.border.label == "top" end)

    border_bottom =
      parts
      |> Enum.filter(fn p -> p.component.border.label == "bottom" end)

    html = Phoenix.View.render_to_string(
            Ewms.WeatheringView, "register_wear_parts_bucket.html",
            equipment: equipment,
            equipment_bucket: equipment_bucket,
            gets: gets,
            parts: parts,
            borders: borders,
            components: components,
            border_left: border_left,
            border_right: border_right,
            border_top: border_top,
            border_bottom: border_bottom)

    broadcast socket, "register_wear_parts_bucket", %{html: html}
    {:noreply, socket}
  end

  def handle_in("get_magnitudes", %{"measurement_id" => measurement_id}, socket) do
    html = Phoenix.View.render_to_string(
            Ewms.WeatheringView, "modal_magnitudes.html", magnitudes: %{})
    broadcast socket, "modal_magnitudes", %{html: html}
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
