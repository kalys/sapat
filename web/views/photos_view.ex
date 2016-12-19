defmodule Sapat.PhotosView do
  use Sapat.Web, :view

  def render("index.json", %{photos: photos}) do
    %{data: render_many(photos, Sapat.PhotosView, "photo.json")}
  end

  def render("show.json", %{photo: photo}) do
    %{data: render_one(photo, Sapat.PhotosView, "photo.json")}
  end

  def render("photo.json", %{photos: photo}) do
    %{id: photo.id,
      photo_url: Sapat.PhotoUploader.url({photo.photo, photo}, :thumb)
    }
  end
end
