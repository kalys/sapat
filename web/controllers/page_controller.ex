defmodule Sapat.PageController do
  use Sapat.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
