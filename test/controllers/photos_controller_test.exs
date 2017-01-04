defmodule Sapat.PhotosControllerTest do
  use Sapat.ConnCase
  alias Sapat.Photo

  @valid_attrs %{photo: %Plug.Upload{filename: "kesha.png", path: "test/fixtures/kesha.png"}}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    {:ok, report} = Forge.saved_report
    conn = post conn, report_photos_path(conn, :create, report.id), photo: @valid_attrs

    photo = assoc(report, :photos) |> first |> Repo.one

    json = json_response(conn, 201)

    assert json["data"]["id"]
    assert json["data"]["photo_url"]
    assert photo

    # clear files from s3 bucket
    photos = Photo |> Repo.all

    for photo <- photos do
      Sapat.PhotoUploader.delete({photo.photo.file_name, photo})
    end

  end
end
