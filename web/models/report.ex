defmodule Sapat.Report do
  use Sapat.Web, :model

  schema "reports" do
    field :description, :string
    field :lat, :float
    field :lng, :float

    belongs_to :user, Sapat.User
    has_many :photos, Sapat.Photo

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :description, :lat, :lng])
    |> validate_required([:user_id, :description, :lat, :lng])
  end
end
