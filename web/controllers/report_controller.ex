defmodule Sapat.ReportController do
  use Sapat.Web, :controller

  alias Sapat.Report

  def index(conn, _params) do
    reports = Repo.all(Report)
    render(conn, "index.json", reports: reports)
  end

  def create(conn, %{"report" => report_params}) do
    changeset = Report.changeset(%Report{}, report_params)

    case Repo.insert(changeset) do
      {:ok, report} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", report_path(conn, :show, report))
        |> render("show.json", report: report)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Sapat.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    report = Repo.get!(Report, id)
    render(conn, "show.json", report: report)
  end

  def update(conn, %{"id" => id, "report" => report_params}) do
    report = Repo.get!(Report, id)
    changeset = Report.changeset(report, report_params)

    case Repo.update(changeset) do
      {:ok, report} ->
        render(conn, "show.json", report: report)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Sapat.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    report = Repo.get!(Report, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(report)

    send_resp(conn, :no_content, "")
  end
end
