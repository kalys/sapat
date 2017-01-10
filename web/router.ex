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

  scope "/", Sapat do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Sapat do
    pipe_through :api

    resources "/users", UserController, only: [:create]

    resources "/reports", ReportController, only: [:index, :create, :show] do
      resources "/photos", PhotosController, only: [:create]
    end

    resources "/photos", PhotosController, only: [:show]

  end
end
