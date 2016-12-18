defmodule Sapat.ReportControllerTest do
  use Sapat.ConnCase

  alias Sapat.Report
  @valid_attrs %{description: "some content", lat: "120.5", lng: "120.5"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    Forge.saved_report_list 5
    conn = get conn, report_path(conn, :index)
    assert length(json_response(conn, 200)["data"]) == 5
  end

  # test "shows chosen resource", %{conn: conn} do
  #   report = Repo.insert! %Report{}
  #   conn = get conn, report_path(conn, :show, report)
  #   assert json_response(conn, 200)["data"] == %{"id" => report.id,
  #     "description" => report.description,
  #     "lat" => report.lat,
  #     "lng" => report.lng}
  # end

  # test "renders page not found when id is nonexistent", %{conn: conn} do
  #   assert_error_sent 404, fn ->
  #     get conn, report_path(conn, :show, -1)
  #   end
  # end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, report_path(conn, :create), report: @valid_attrs

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Report, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, report_path(conn, :create), report: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  # test "updates and renders chosen resource when data is valid", %{conn: conn} do
  #   report = Repo.insert! %Report{}
  #   conn = put conn, report_path(conn, :update, report), report: @valid_attrs
  #   assert json_response(conn, 200)["data"]["id"]
  #   assert Repo.get_by(Report, @valid_attrs)
  # end

  # test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
  #   report = Repo.insert! %Report{}
  #   conn = put conn, report_path(conn, :update, report), report: @invalid_attrs
  #   assert json_response(conn, 422)["errors"] != %{}
  # end

  # test "deletes chosen resource", %{conn: conn} do
  #   report = Repo.insert! %Report{}
  #   conn = delete conn, report_path(conn, :delete, report)
  #   assert response(conn, 204)
  #   refute Repo.get(Report, report.id)
  # end
end
