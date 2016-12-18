defmodule Sapat.Photo do
  use Sapat.Web, :model

  schema "photos" do
    field :photo, :string
    belongs_to :report, Sapat.Report

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:photo])
    |> validate_required([:photo])
  end
end
