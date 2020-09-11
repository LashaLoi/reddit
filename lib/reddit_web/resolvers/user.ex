defmodule RedditWeb.Resolvers.User do
  alias Reddit.Auth
  alias Helpers.FormatData

  def me(_root, _params, %{context: %{id: user_id}}), do: {:ok, Auth.get_user!(user_id)}

  def get_posts(%{posts: posts}, %{limit: limit, offset: offset}, _info) do
    {:ok, Enum.slice(posts, offset, limit)}
  end

  def get_posts(%{posts: posts}, _params, _info), do: {:ok, posts}

  def login(_root, params, _info) do
    case Auth.login(params) do
      {:ok, user} -> FormatData.format_response(user, :user)
      {:error, error_message} -> FormatData.format_response(error_message, :user)
    end
  end

  def register(_root, %{input: input}, _info) do
    case Auth.register(input) do
      {:ok, user} -> FormatData.format_response(user, :user)
      {:error, error_message} -> FormatData.format_response(error_message, :user)
    end
  end

  def forgot_password(
        _root,
        %{new_password: new_password, confirm_new_password: confirm_new_password},
        %{context: %{id: user_id}}
      ) do
    with true <- new_password === confirm_new_password,
         true <- String.length(new_password) > 3,
         true <- Auth.update_password(new_password, user_id) do
      {:ok, true}
    else
      _ -> {:ok, false}
    end
  end
end
