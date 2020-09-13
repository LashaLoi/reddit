defmodule RedditWeb.Router do
  use RedditWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug RedditWeb.Context
  end

  scope "/api", RedditWeb do
    pipe_through :api
  end

  scope "/" do
    pipe_through :graphql
    pipe_through :api

    forward "/graphql", Absinthe.Plug.GraphiQL,
      schema: RedditWeb.Schema,
      socket: RedditWeb.UserSocket,
      interface: :advanced,
      context: %{pubsub: RedditWeb.Endpoint}
  end
end
