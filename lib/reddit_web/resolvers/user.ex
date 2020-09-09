defmodule RedditWeb.Resolvers.User do
  alias Reddit.Auth

  def register(_root, %{input: input}, _info) do
    case Auth.register(input) do
      {:ok, user} -> {:ok, user}
      _ -> {:error, "unable to create user"}
    end
  end

  def login(_root, params, _info) do
    case Auth.login(params) do
      {:ok, user} -> {:ok, user}
      {:error, message} -> {:error, message}
    end
  end
end
