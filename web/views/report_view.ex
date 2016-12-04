defmodule Sapat.ReportView do
  use Sapat.Web, :view

  def render("index.json", %{reports: reports}) do
    %{data: render_many(reports, Sapat.ReportView, "report.json")}
  end

  def render("show.json", %{report: report}) do
    %{data: render_one(report, Sapat.ReportView, "report.json")}
  end

  def render("report.json", %{report: report}) do
    %{id: report.id,
      description: report.description,
      lat: report.lat,
      lng: report.lng}
  end
end
