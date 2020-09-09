defmodule RedditWeb.Router do
  use RedditWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RedditWeb do
    pipe_through :api
  end
end
