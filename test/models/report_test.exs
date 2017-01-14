defmodule Sapat.ReportTest do
  use Sapat.ModelCase

  alias Sapat.Report

  @valid_attrs %{description: "some content", lat: "120.5", lng: "120.5", user_id: "123"}
  @invalid_attrs %{}
  @uncomplete_attrs %{description: "some content"}

  test "changeset with valid attributes" do
    changeset = Report.changeset(%Report{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Report.changeset(%Report{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with uncomplete attributes" do
    changeset = Report.changeset(%Report{}, @uncomplete_attrs)
    refute changeset.valid?
  end

  test "has_many photos association" do
    {:ok, report} = Forge.saved_report
    Forge.saved_photo_list 3, report: report

    # actual_report = Repo.get!(Report, report.id, preload: )
    actual_report = Report |> preload(:photos) |> first |> Repo.one
    assert length(actual_report.photos) == 3
  end
end
