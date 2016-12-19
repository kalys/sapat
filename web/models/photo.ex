defmodule Sapat.Photo do
  use Sapat.Web, :model
  use Arc.Ecto.Schema

  schema "photos" do
    field :photo, Sapat.PhotoUploader.Type
    field :uuid, :string
    belongs_to :report, Sapat.Report

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:report_id, :uuid])
    |> cast_attachments(params, [:photo])
    |> validate_required([:report_id, :photo, :uuid])
  end
end
