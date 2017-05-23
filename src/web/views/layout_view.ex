defmodule Ewms.LayoutView do
  use Ewms.Web, :view

  def menu_active(conn, assigns) do
    render_existing(view_module(conn), "menu_active", Dict.put(assigns, :action_name, action_name(conn)))
      || default_menu_active(conn, assigns)
  end

  def default_menu_active(_conn, _assigns) do
    "Dashboard"
  end

end
