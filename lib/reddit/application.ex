defmodule Reddit.Application do
  use Application

  def start(_type, _params) do
    children = [
      Reddit.Repo,
      RedditWeb.Endpoint,
      {Absinthe.Subscription, RedditWeb.Endpoint}
    ]

    opts = [strategy: :one_for_one, name: Reddit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    RedditWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
