defmodule Sapat.PhotosController do
  use Sapat.Web, :controller
  alias Sapat.Photo
  alias Sapat.Report

  def create(conn, %{"photo" => photo_params, "report_id" => report_id}) do
    report = Repo.get(Report, report_id)
    photo_params = Map.merge(photo_params, 
       %{"report_id" => report.id, "uuid" => Ecto.UUID.bingenerate()})

    changeset = Photo.changeset(%Photo{}, photo_params)

    case Repo.insert(changeset) do
      {:ok, photo} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", photos_path(conn, :show, photo.id))
        |> render("show.json", photo: photo)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Sapat.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
