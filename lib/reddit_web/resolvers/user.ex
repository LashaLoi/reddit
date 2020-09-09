defmodule RedditWeb.Resolvers.User do
  alias Reddit.Auth

  def me(_root, _args, %{context: %{id: user_id}}) do
    IO.inspect(user_id)

    {:ok, Auth.get_user!(user_id)}
  end

  def register(_root, %{input: input}, _info) do
    case Auth.register(input) do
      {:ok, user} -> format_response(user)
      {:error, error_message} -> format_response(error_message)
    end
  end

  def login(_root, params, _info) do
    case Auth.login(params) do
      {:ok, user} -> format_response(user)
      {:error, error_message} -> format_response(error_message)
    end
  end

  defp format_response(error_message) when is_binary(error_message) do
    {:ok, %{user: nil, error_message: error_message}}
  end

  defp format_response(user), do: {:ok, %{user: user, error_message: nil}}
end
