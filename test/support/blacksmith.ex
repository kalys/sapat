defmodule Blacksmith.Config do
  def save(map) do
    Sapat.Repo.insert(map)
  end

  def save_all(list_of_models) do
    Enum.map(list_of_models, &Sapat.Repo.insert/1)
  end
end

defmodule Forge do
  use Blacksmith
  alias Sapat.Report
  alias Sapat.Photo
  alias Sapat.User
  alias Sapat.Session

  @save_one_function &Blacksmith.Config.save/1
  @save_all_function &Blacksmith.Config.save_all/1

  register :report, %Report{
    description: "some description",
    lat: 0.153535,
    lng: 12.35435
  }

  register :photo, %Photo{
    photo: %{file_name: "kesha.png", updated_at: nil},
    report: Forge.saved_report
  }

  register :user, %User{
    email: Sequence.next(:email, &"test#{&1}@example.com"),
    password: "passwd"
  }

  register :session, %Session{
    token: "ololotrololo"
  }
end
