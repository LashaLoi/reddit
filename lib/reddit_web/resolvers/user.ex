defmodule RedditWeb.Resolvers.User do
  alias Reddit.Auth
  alias Helpers.FormatData

  def me(_root, _args, %{context: %{id: user_id}}), do: {:ok, Auth.get_user!(user_id)}

  def register(_root, %{input: input}, _info) do
    case Auth.register(input) do
      {:ok, user} -> FormatData.format_response(user, :user)
      {:error, error_message} -> FormatData.format_response(error_message, :user)
    end
  end

  def login(_root, params, _info) do
    case Auth.login(params) do
      {:ok, user} -> FormatData.format_response(user, :user)
      {:error, error_message} -> FormatData.format_response(error_message, :user)
    end
  end
end
