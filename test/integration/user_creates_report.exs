defmodule Sapat.AboutIntegrationTest do
  use Sapat.IntegrationCase, async: true

  alias Sapat.User
  alias Sapat.Report

  @valid_attrs %{email: "john.doe@expample.com", password: "s3cr3t"}
  @valid_reports_attrs %{description: "some content", lat: "120.5", lng: "120.5"}

  setup %{conn: conn} do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    Repo.insert(changeset)
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "user creates a report", %{conn: conn} do
    # sign in
    session_conn = post conn, session_path(conn, :create), user: @valid_attrs
    token = json_response(session_conn, 201)["data"]["token"]

    # create a report
    report_conn = conn
           |> put_req_header("x-auth", "Token: " <> token)
           |> post(report_path(conn, :create), report: @valid_reports_attrs)

    assert json_response(report_conn, 201)["data"]["id"]
    assert Repo.get_by(Report, @valid_reports_attrs)
  end
end
