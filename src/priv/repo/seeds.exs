# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ewms.Repo.insert!(%Ewms.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Comeonin.Bcrypt

# Carga de datos de la tabla de bordes
Ewms.Repo.insert!(%Ewms.Border{id: "ff14d21b-89d6-4e5e-8f9c-826656e6b7af", name: "Izquierdo", label: "left"})
Ewms.Repo.insert!(%Ewms.Border{id: "8b47eeaf-4f05-4586-b032-655bf6a57d64", name: "Derecho", label: "right"})
Ewms.Repo.insert!(%Ewms.Border{id: "3cdc1e6e-2399-4a88-b534-1a8c328759ac", name: "Superior", label: "top"})
Ewms.Repo.insert!(%Ewms.Border{id: "cc4df255-ab49-418e-8c46-437d857778e8", name: "Inferior", label: "bottom"})

# Cargar User por default
Ewms.Repo.insert!(%Ewms.User{id: "613d3d94-7379-4b4b-bf25-2225d14b9034",
                            name: "Administrador del Sistema",
                            email: "admin@ewms.pe",
                            username: "admin",
                            is_admin: true,
                            password_hash: "P@ssw0rd!" |> Bcrypt.hashpwsalt()}
                            |> Ewms.Repo.preload(:authorizations))
