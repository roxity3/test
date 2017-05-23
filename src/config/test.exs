use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ewms, Ewms.Endpoint,
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ewms, Ewms.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  database: System.get_env("DB_NAME"),
  hostname: System.get_env("DB_HOST"),
  port: System.get_env("DB_PORT"),
  pool: Ecto.Adapters.SQL.Sandbox
