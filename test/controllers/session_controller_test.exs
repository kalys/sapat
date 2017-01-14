defmodule Sapat.SessionControllerTest do
  use Sapat.ConnCase

  alias Sapat.Session
  alias Sapat.User

  @valid_attrs %{email: "foo@bar.com", password: "s3cr3t"}

  setup %{conn: conn} do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    Repo.insert(changeset)
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: @valid_attrs
    token = json_response(conn, 201)["data"]["token"]
    assert token
    assert Repo.get_by(Session, token: token)
  end

  test "does not create resource and renders error when password is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: Map.put(@valid_attrs, :password, "notright")
    assert json_response(conn, 401)["errors"] != %{}
  end

  test "does not create resource and renders error when email is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: Map.put(@valid_attrs, :email, "not@found.com")
    assert json_response(conn, 401)["errors"] != %{}
  end

  test "renders requested resources when user is authenticated", %{conn: conn} do
    {:ok, another_user} = Forge.saved_user email: "koko@koko.com"
    Forge.saved_report user: another_user

    user = Repo.get_by(User, email: "foo@bar.com")
    Forge.saved_report user: user

    {:ok, session} = Forge.saved_session user: user

    conn = put_req_header conn, "x-auth", "Token: " <> session.token
    conn = get conn, report_path(conn, :my_reports)
    data = json_response(conn, 200)["data"]
    assert length(data) == 1
  end

  test "renders error when user is not authenticated", %{conn: _conn} do
  end

end
