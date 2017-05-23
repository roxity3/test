defmodule Ewms.PageController do
  use Ewms.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end
