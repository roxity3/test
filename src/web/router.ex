defmodule Ewms.Router do
  use Ewms.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Ewms.Auth, repo: Ewms.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ewms do
    pipe_through :browser # Use the default browser stack
    #pipe_through [:browser, :browser_session, :auth]
    # We pipe this through the browser_auth to fetch logged in people
    # We pipe this through the impersonation_browser_auth to know if we're impersonating
    # We don't just pipe it through admin_browser_auth because that also loads the resource
    #pipe_through [:browser, :browser_auth, :impersonation_browser_auth]

    # Session
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    # Home
    get "/", PageController, :index
    get "/registry", PageController, :registry
    get "/reports", PageController, :reports
    get "/maintenances", PageController, :maintenances
    get "/catalogs", PageController, :catalogs
    get "/security", PageController, :security

    # Users
    #resources "/users", UserController, only: [:new, :create]
    #resources "/sessions", SessionController, only: [:new, :create, :delete]

  end

  # registry
  scope "/registry/", Ewms do
    pipe_through :browser # Use the default browser stack

    # Weathering
    get "/weatherings", WeatheringController, :index
    get "/weatherings/customers/:customer_id", WeatheringController, :projects
    get "/weatherings/customers/:customer_id/projects/:project_id", WeatheringController, :equipments
    get "/weatherings/customers/:customer_id/projects/:project_id/equipments/:equipment_id", WeatheringController, :equipment_bucket
    post "/weatherings/update/", WeatheringController, :update
  end

  # maintenances
  scope "/maintenances/", Ewms do
    pipe_through :browser # Use the default browser stack

    # Maestras
    resources "/customers", CustomerController do
      resources "/projects", ProjectController do
        resources "/equipments", EquipmentController do
          resources "/buckets", EquipmentBucketController
        end
        resources "/buckets", BucketController do
          resources "/parts", GetController
          #resources "/parts", BucketPartController
        end
      end
    end


    resources "/parts", PartController do
      resources "/prices", PriceController

      resources "/measurements", MeasurementController do
        resources "/magnitudes", MagnitudeController
      end
    end
  end

  # catalogs
  scope "/catalogs/", Ewms do
    pipe_through :browser # Use the default browser stack

    resources "/manufacturers", ManufacturerController
    resources "/components", ComponentController
    resources "/systems", SystemController
    resources "/models", ModelController
    resources "/kpis", KpiController
    resources "/units", UnitController
    resources "/conditions", ConditionController
    resources "/states", StateController
    resources "/events", EventController
  end

  # security
  scope "/security/", Ewms do
    pipe_through :browser # Use the default browser stack

    #delete "/logout", AuthController, :logout
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ewms do
  #   pipe_through :api
  # end
end
