defmodule RedditWeb.Router do
  use RedditWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RedditWeb do
    pipe_through :api
  end

  scope "/" do
    # pipe_through :graphql
    pipe_through :api

    forward "/graphql", Absinthe.Plug.GraphiQL,
      schema: RedditWeb.Schema,
      interface: :playground,
      context: %{pubsub: RedditWeb.Endpoint}
  end
end
