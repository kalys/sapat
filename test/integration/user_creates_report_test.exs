defmodule Sapat.UserCreatesReportTest do
  use Sapat.IntegrationCase, async: true

  alias Sapat.User
  alias Sapat.Report

  @valid_user_attrs %{email: "john.doe@expample.com", password: "s3cr3t"}
  @valid_reports_attrs %{description: "some content", lat: "120.5", lng: "120.5"}

  setup %{conn: conn} do
    changeset = User.registration_changeset(%User{}, @valid_user_attrs)
    Repo.insert(changeset)
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "user creates a report", %{conn: conn} do
    # sign in
    %{"data" => %{"token" => token}} = conn
      |> post(session_path(conn, :create), user: @valid_user_attrs)
      |> json_response(201)

    # create a report
    %{"data" => %{"id" => id}} = conn
      |> put_req_header("x-auth", "Token: " <> token)
      |> post(report_path(conn, :create), report: @valid_reports_attrs)
      |> json_response(201)

    assert Repo.get(Report, id)
  end
end
