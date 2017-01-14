defmodule Sapat.Authentication do

  alias Sapat.Session

  def validate({conn, token}) do
    session = Sapat.Repo.get_by(Session, token: token)
    case session do
      %Session{user_id: user_id} ->
        {:ok, user_id, conn}
      _ ->
        {:error, [], conn}
    end
  end

end
