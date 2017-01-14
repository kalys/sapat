defmodule Sapat.Router do
  use Sapat.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Mellon, validator: {Sapat.Authentication, :validate, []}, header: "x-auth"
  end

  scope "/", Sapat do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Authenticated routes
  scope "/api", Sapat do
    pipe_through :api
    pipe_through :authenticated

    get "/reports/my", ReportController, :my_reports
    resources "/reports", ReportController, only: [:create] do
      resources "/photos", PhotosController, only: [:create]
    end

    resources "/photos", PhotosController, only: [:show]
  end

  scope "/api", Sapat do
    pipe_through :api

    resources "/users", UserController, only: [:create]
    resources "/sessions", SessionController, only: [:create]
    resources "/reports", ReportController, only: [:index, :show]
  end
end
