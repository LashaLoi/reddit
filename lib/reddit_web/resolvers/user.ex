defmodule RedditWeb.Resolvers.User do
  alias Reddit.Auth

  def register(_root, %{input: input}, _info) do
    case Auth.register(input) do
      {:ok, user} -> {:ok, %{user: user, error_message: nil}}
      _ -> {:ok, %{user: nil, error_message: "Unable to create user"}}
    end
  end

  def login(_root, params, _info) do
    case Auth.login(params) do
      {:ok, user} ->
        {:ok, %{user: user, error_message: nil}}

      {:error, error_message} ->
        {:ok, %{user: nil, error_message: error_message}}
    end
  end
end
